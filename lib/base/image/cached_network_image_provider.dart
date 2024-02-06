import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:mewtwo/constants.dart';
import 'package:mewtwo/utils.dart';
import 'package:path_provider/path_provider.dart';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'lru_cache.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import './multiframe_image_provider.dart';

///三级缓存的provider，可用于[Image],[DecorationImage] 等
/// memory，disk，net
class BBCachedNetworkImageProvider extends MultiFrameImageProvider<BBCachedNetworkImageProvider> {
  final String url;

  final double scale;

  bool _isInMemoryCache = true;

  final int? targetWidth;
  final int? targetHeight;

  BBCachedNetworkImageProvider(this.url,
      {this.scale = 1.0, bool needMemoryCache = true, this.targetWidth, this.targetHeight})
      : super(needMemoryCache: needMemoryCache);

  @override
  ImageStreamCompleter loadBuffer(BBCachedNetworkImageProvider key, DecoderBufferCallback decode) {
    final StreamController<ImageChunkEvent> chunkEvents = StreamController<ImageChunkEvent>();

    /// 走到load，说明在[imageCache]里没有缓存
    _isInMemoryCache = false;

    return BBMultiFrameImageStreamCompleter(
      codec: _loadAsync(key, chunkEvents, decode),
      chunkEvents: chunkEvents.stream,
      scale: key.scale,
      debugLabel: key.url,
      informationCollector: () {
        return <DiagnosticsNode>[
          DiagnosticsProperty<ImageProvider>('Image provider', this),
          DiagnosticsProperty<BBCachedNetworkImageProvider>('Image key', key),
        ];
      },
    );
  }

  @override
  Future<BBCachedNetworkImageProvider> obtainKey(ImageConfiguration? configuration) {
    return SynchronousFuture<BBCachedNetworkImageProvider>(this);
  }

  /// 获取图片size
  Future<Size?> getImageSize(List<int> data) async {
    if (data == null) return null;
    ImmutableBuffer? buffer;
    ui.ImageDescriptor? descriptor;
    try {
      buffer = await ImmutableBuffer.fromUint8List(
        Uint8List.fromList(data)
        );
      descriptor = await ui.ImageDescriptor.encoded(buffer);
      return Size(descriptor.width * 1.0, descriptor.height * 1.0);
    } catch (e, s) {
    } finally {
      buffer?.dispose();
      descriptor?.dispose();
    }
    return null;
  }

  // real to load
  Future<ui.Codec> _loadAsync(BBCachedNetworkImageProvider key, StreamController<ImageChunkEvent> chunkEvents,
      DecoderBufferCallback decode) async {
    try {
      File cacheFile = diskFile;
      bool existsDiskCache = await ImageCachedManager.instance.existsCache(cacheFile.path);
      if (existsDiskCache) {
        Uint8List imgData = cacheFile.readAsBytesSync();
        if (imgData == null || imgData.isEmpty) {
          /// 如果缓存判断失误，重新下载
          scheduleMicrotask(() {
            PaintingBinding.instance.imageCache.evict(key);
          });
          ImageCachedManager.instance.evictMemoryCache(cacheFile.path);
          await ImageCachedManager.instance.downloadAndCache(url, diskFile, chunkEvents);
          if (imgData == null || imgData.isEmpty) {
            scheduleMicrotask(() {
              PaintingBinding.instance.imageCache.evict(key);
            });
            throw PTImageException("download image error!!!", url);
          }
        }
        int? decodeWidth = null, decodeHeight = null;
        if (targetWidth != null && targetHeight != null) {
          Size? rawSize = await getImageSize(imgData);
          if (rawSize != null) {
            if (rawSize.width / targetWidth! >= 3) {
              decodeWidth = targetWidth;
            }
            if (rawSize.height / targetHeight! >= 3) {
              decodeHeight = targetHeight;
            }
          }
        }
        final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(imgData);
        return decode(buffer, cacheWidth: decodeWidth, cacheHeight: decodeHeight);
      } else {
        Uint8List? imgData = await ImageCachedManager.instance.downloadAndCache(url, diskFile, chunkEvents);
        if (imgData == null || imgData.isEmpty) {
          scheduleMicrotask(() {
            PaintingBinding.instance.imageCache.evict(key);
          });
          throw PTImageException("download image error!!!", url);
        }
        int? decodeWidth = null, decodeHeight = null;
        if (targetWidth != null && targetHeight != null) {
          Size? rawSize = await getImageSize(imgData);
          if (rawSize != null) {
            if (rawSize.width / targetWidth! >= 3) {
              decodeWidth = targetWidth!;
            }
            if (rawSize.height / targetHeight! >= 3) {
              decodeHeight = targetHeight!;
            }
          }
        }
        final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(imgData);
        return decode(buffer, cacheWidth: decodeWidth, cacheHeight: decodeHeight);
      }
    } catch (e) {
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      rethrow;
    } finally {
      chunkEvents?.close();
    }
  }

  File get diskFile => ImageCachedManager.instance.getFileByUrl(url);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;

    return other is BBCachedNetworkImageProvider &&
        other.url == url &&
        other.scale == scale &&
        other.targetWidth == targetWidth &&
        other.targetHeight == targetHeight;
  }

  @override
  int get hashCode => Object.hash(url, scale, targetWidth, targetHeight);

  @override
  String toString() =>
      '${objectRuntimeType(this, 'BBCachedNetworkImageProvider')}("$url", scale: $scale, targetWidth: $targetWidth, targetHeight: $targetHeight )';

  bool get isInMemoryCache => _isInMemoryCache;
}

/// 磁盘缓存
class ImageCachedManager {
  static ImageCachedManager? _ins;
  late Dio _dio;
  static ImageCachedManager get instance => _ins ??= ImageCachedManager._();

  ImageCachedManager._() {
    _initDio();
  }

  _initDio() {
    _dio = Dio(BaseOptions(connectTimeout: Duration(milliseconds: 5000)
    , receiveTimeout: Duration(milliseconds: 30000)));
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cr, String host, int port) {
        return true;
      };
      client.findProxy = null;
    };
  }

  /// url md5 cache,减少md5次数
  LruCache<String, String> _md5Cache = LruCache(1000);

  /// img exists cache,减少读取文件状态次数
  LruCache<String, int> _existsCached = LruCache(1000);
  final int _maxCheckDuration = 1000 * 60 * 10;

  

  _md5ByCache(String url) {
    return _md5Cache.putIfAbsent(url, () => _md5(url));
  }

  String _md5(String data) {
    final content = const Utf8Encoder().convert(data);
    final digest = md5.convert(content);
    return hex.encode(digest.bytes).toLowerCase();
  }

  /// 获取缓存文件路径
  String getFilePathByUrl(String url) {
    
    String key = _md5ByCache(url);
    String path = join(Constants.tempDir.path, key);
    return path;
  }

  File getFileByUrl(String url) {
    String path = getFilePathByUrl(url);
    return File(path);
  }

  /// 缓存文件是否存在
  Future<bool> existsCache(String pathOrUrl) async {
    String path = _getRealPath(pathOrUrl);
    int now = DateTime.now().millisecondsSinceEpoch;
    if (_existsCached.containsKey(path) && now - _existsCached[path]! < _maxCheckDuration) {
      return true;
    }
    bool ok = await File(path).exists();
    if (ok) {
      _existsCached[path] = now;
    } else {
      _existsCached.remove(path);
    }
    return ok;
  }

  String _getRealPath(String pathOrUrl) {
    if (pathOrUrl != null && pathOrUrl.startsWith('http')) {
      return getFilePathByUrl(pathOrUrl);
    }
    return pathOrUrl;
  }

  /// 移除exists缓存
  Future<bool> evictMemoryCache(String pathOrUrl) async {
    _existsCached.remove(_getRealPath(pathOrUrl));
    if (pathOrUrl != null && pathOrUrl.startsWith('http')) {
      BBCachedNetworkImageProvider provider = BBCachedNetworkImageProvider(pathOrUrl);
      Object key = await provider.obtainKey(null);
      imageCache.evict(key);
    }
    return true;
  }

  /// 移除本地缓存
  void evictDiskCache(String pathOrUrl) {
    try {
      String path = _getRealPath(pathOrUrl);
      if (File(path) != null && File(path).existsSync()) {
        File(path).deleteSync(recursive: false);
      }
       
      
    } catch (e, s) {
      
    }
  }

  void evictCache(String pathOrUrl) {
    try {
      evictMemoryCache(pathOrUrl);
      evictDiskCache(pathOrUrl);
    } catch (e, s) {
      
    }
  }

  /// 提前缓存
  Future preCache(String url) async {
    BBCachedNetworkImageProvider provider = BBCachedNetworkImageProvider(url);
    BBCachedNetworkImageProvider key = await provider.obtainKey(null);
    imageCache.putIfAbsent(
        key, () => provider.loadBuffer(key, PaintingBinding.instance.instantiateImageCodecFromBuffer));
  }

  /// 下载并缓存
  Future<Uint8List?> downloadAndCache(String url, File saveFile, StreamController<ImageChunkEvent> chunkEvents) async {
    if (url == null || url.isEmpty) {
      return null;
    }
    Uint8List? resData = null;
    bool downloadSuccess = true;
    for (int i = 0; i < 3; i++) {
      try {
        
        int bodySize = 0;
        Response<List<int>> resp = await _dio.get<List<int>>(url, options: Options(responseType: ResponseType.bytes),
            onReceiveProgress: (int received, int total) {
          if (chunkEvents != null) {
            chunkEvents.add(ImageChunkEvent(
              cumulativeBytesLoaded: received,
              expectedTotalBytes: total,
            ));
          }
          if (bodySize != total) {
            bodySize = total;
          }
        });

        if (resp.headers == null ||
            (resp.headers[Headers.contentLengthHeader] != null &&
                Utility.parseInt(resp.headers[Headers.contentLengthHeader]![0]) != bodySize)) {
          /// donoting
          downloadSuccess = false;
        } else {
          
          
          List<int> data = resp.data as List<int>;
          resData = Uint8List.fromList(data);
          saveFile.writeAsBytesSync(data);
          break;
        }
        
      } catch (e, s) {
        downloadSuccess = false;
      }
    }
    if (!downloadSuccess) {
      try {
        if (saveFile != null && saveFile.existsSync()) {
      try {
        saveFile.deleteSync(recursive: false);
      } catch (e, s) {
        
      }
    }
     
      } catch (e) {
     
      }
    }
    return resData;
  }
}

class PTImageException implements Exception {
  final String message;
  final String imageUrl;

  const PTImageException(this.message, this.imageUrl);

  String toString() {
    if (message == null) return "PTImageException";
    return "YGException: $message, imageUrl: $imageUrl";
  }
}
