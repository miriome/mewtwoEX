import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/io.dart';
import 'package:mewtwo/constants.dart';

import 'cached_network_image_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/semantics.dart';
import 'package:path/path.dart';

class DefaultPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}

/// 新版网络图片，使用自定义的imageProvider实现三级缓存
class CachedNetworkImage extends StatelessWidget {
  const CachedNetworkImage(
      {Key? key,
      this.placeholder,
      required this.imageUrl,
      this.errorWidget,
      this.fadeOutDuration = const Duration(milliseconds: 300),
      this.fadeOutCurve = Curves.easeOut,
      this.fadeInDuration = const Duration(milliseconds: 300),
      this.fadeInCurve = Curves.easeIn,
      this.scale = 1.0,
      this.width,
      this.height,
      this.fit,
      this.centerSlice,
      this.colorBlendMode,
      this.filterQuality = FilterQuality.low,
      this.color,
      this.playback = true, //图片切换不会显示空白或者loading
      this.alignment = Alignment.center,
      this.repeat = ImageRepeat.noRepeat,
      this.matchTextDirection = false,
      this.httpHeaders,
      this.cachedWidth,
      this.cachedHeight,
      this.loadComplete,
      this.disableCached = false})
      : assert(imageUrl != null),
        assert(fadeOutDuration != null),
        assert(fadeOutCurve != null),
        assert(fadeInDuration != null),
        assert(fadeInCurve != null),
        assert(alignment != null),
        assert(repeat != null),
        assert(filterQuality != null),
        assert(matchTextDirection != null),
        super(key: key);

  static previewLoad() {}

  final Widget? placeholder;
  final String imageUrl;
  final Widget? errorWidget;

  final Duration fadeOutDuration;
  final Curve fadeOutCurve;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  final Function? loadComplete;

  final double scale;
  final FilterQuality filterQuality;
  final Rect? centerSlice;
  final BlendMode? colorBlendMode;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final Map<String, String>? httpHeaders;
  final bool playback;
  final int? cachedWidth;
  final int? cachedHeight;

  final bool disableCached;

  @override
  Widget build(BuildContext context) {
    return _buildV2Image(context);
  }

  Widget _buildV2Image(BuildContext context) {
    // final fullImageUrl = ((width != null || height != null) && imageUrl.startsWith('http') && !imageUrl.contains('?'))
    //     ? '$imageUrl?x-oss-process=image/resize${width != null ? ',w_${Util.parseInt(width.dr)}' : ''}${height != null ? ',h_${Util.parseInt(height.dr)}' : ''}'
    //     : imageUrl;
    // final fullImageUrl = Util.autoResizeImageURL(
    //   url: imageUrl,
    //   width: width,
    //   height: height,
    // );
    
    final fullImageUrl = imageUrl;
    BBCachedNetworkImageProvider cacheProvider = BBCachedNetworkImageProvider(fullImageUrl,
        scale: scale);
        // targetWidth: (!disableCached && cachedWidth == null) ? Util.getCommonCacheSize(width) : null,
        // targetHeight: (!disableCached && cachedHeight == null) ? Util.getCommonCacheSize(height) : null);
    // ImageProvider provider = ResizeImage.resizeIfNeeded(cachedWidth ?? Util.getCommonCacheSize(width),
    //     cachedHeight ?? Util.getCommonCacheSize(height), cacheProvider);

    ImageProvider provider = ResizeImage.resizeIfNeeded(cachedWidth, cachedHeight, cacheProvider);

    // ignore: prefer_function_declarations_over_variables
    ImageFrameBuilder frameBuilder = (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        if (frame == null) {
          return Center(child: _displayLoading(),);
        }
        return FadeWidget(
          duration: fadeInDuration,
          curve: fadeInCurve,
          child: child,
        );
      };

    ImageLoadingBuilder? loadingBuilder;
    if (loadComplete != null) {
      loadingBuilder = (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress != null &&
            loadingProgress.cumulativeBytesLoaded >= (loadingProgress.expectedTotalBytes ?? 0)) {
          loadComplete!();
        }
        return child;
      };
    }

    return Image(
      image: provider,
      width: width,
      height: height,
      color: color,
      fit: fit,
      colorBlendMode: colorBlendMode,
      repeat: repeat,
      alignment: alignment,
      filterQuality: filterQuality,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      frameBuilder: frameBuilder,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: width,
          height: height,
          child: errorWidget ?? Container(),
        );
      },
      loadingBuilder: loadingBuilder,
    );
  }

  _displayLoading() {
    if (placeholder != null) {
      return placeholder;
    } else {
      return _displayEmpty();
    }
  }

  _displayEmpty() {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}

enum DownloadState { loading, complete, display, error }

/// The direction in which an animation is running.
enum AnimationDirection {
  /// The animation is running from beginning to end.
  forward,

  /// The animation is running backwards, from end to beginning.
  reverse,
}

/// Helper Widget to Fade in or out
class FadeWidget extends StatefulWidget {
  /// Child widget being faded
  final Widget child;

  /// Fade duration
  final Duration duration;

  /// Duration direction, forward is from invisible to visible
  final AnimationDirection direction;

  /// Animation curve. See [Curves] for more options.
  final Curve curve;

  /// Fading [child] in or out depending on [direction] with a [curve] and
  /// [duration]./
  const FadeWidget(
      {required this.child,
      this.duration = const Duration(milliseconds: 800),
      this.direction = AnimationDirection.forward,
      this.curve = Curves.easeOut,
      Key? key})
      : super(key: key);

  @override
  _FadeWidgetState createState() => _FadeWidgetState();
}

class _FadeWidgetState extends State<FadeWidget> with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;
  late bool hideWidget;

  @override
  Widget build(BuildContext context) {
    if (hideWidget) {
      return const SizedBox.shrink();
    }

    return FadeTransition(
      opacity: opacity,
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this);
    final curved = CurvedAnimation(parent: controller, curve: widget.curve);
    final begin = widget.direction == AnimationDirection.forward ? 0.0 : 1.0;
    final end = widget.direction == AnimationDirection.forward ? 1.0 : 0.0;
    opacity = Tween<double>(begin: begin, end: end).animate(curved);
    controller.forward();

    hideWidget = false;
    if (widget.direction == AnimationDirection.reverse) {
      opacity.addStatusListener(animationStatusChange);
    }
  }

  @override
  void dispose() {
    opacity.removeStatusListener(animationStatusChange);
    controller.dispose();
    super.dispose();
  }

  void animationStatusChange(AnimationStatus status) {
    if (mounted)
      setState(() {
        hideWidget = widget.direction == AnimationDirection.reverse && status == AnimationStatus.completed;
      });
  }
}

class DownloadEntry extends ValueNotifier<DownloadState> {
  final String url;
  final int index;
  late File? _image;

  DownloadEntry({required this.url, required this.index}) : super(DownloadState.loading);

  @override
  void dispose() {
    super.dispose();
  }

  File? get image {
    return _image;
  }

  set image(File? value) {
    _image = value;
  }
}

// class PreCache {
//   final String url;
//   final BuildContext context;
//   late DownloadEntry _entry;
//   PreCache(this.context, this.url) {
//     _init();
//   }

//   _init() {
//     _entry = CachedImageManager.instance().add(url);
//     _entry.addListener(_onStateChanged);
//   }

//   _onStateChanged() {
//     if (_entry.value == DownloadState.complete) {
//       _entry.removeListener(_onStateChanged);
//       final FileImage image = FileImage(_entry.image, scale: 1.0);

//       image.resolve(createLocalImageConfiguration(
//         context ?? Constant.context,
//         size: null,
//       ));
//       _entry = null;
//     } else if (_entry.value == DownloadState.error) {
//       _dispose();
//     }
//   }

//   _dispose() {
//     if (_entry != null) {
//       _entry.removeListener(_onStateChanged);
//       _entry = null;
//     }
//   }
// }

class CachedImageManager extends ValueNotifier<ConnectivityResult> {
  static CachedImageManager? _instance;
  static CachedImageManager instance() {
    if (_instance == null) {
      _instance = CachedImageManager();
    }
    return _instance!;
  }

  Map<int, DownloadEntry> _data = {};
  Map<String, List<int>> _res = {};
  late StreamSubscription<ConnectivityResult> _stream;
  int _index = 0;
  late Connectivity _conn;

  CachedImageManager() : super(ConnectivityResult.none) {
    _conn = Connectivity();
    _stream = _conn.onConnectivityChanged.listen(_onNetworkChanged);
  }

  void _onNetworkChanged(ConnectivityResult result) {
    if (value != result) {
      value = result;
    }
  }

  // static PreCache preCache(BuildContext context, String url, {double width, double height}) {
  //   // return PreCache(context, url);
  //   return PreCache(context, Util.autoResizeImageURL(url: url, width: width, height: height));
  // }

  DownloadEntry add(String url) {
    if (url == null) url = '';
    _index++;
    DownloadEntry entry = DownloadEntry(
      url: url,
      index: _index,
    );
    _data[_index] = entry;
    if (!_res.containsKey(url)) {
      _res[url] = [];
    }
    _res[url]!.add(_index);
    if (_res[url]!.length == 1) {
      _download(url);
    }
    return entry;
  }

  Map<String, String> _cache = {};
  _md5ByCache(String url) {
    if (_cache.containsKey(url)) {
      return _cache[url];
    } else {
      String key = _md5(url);
      _cache[url] = key;
      return key;
    }
  }

  Map<String, int> _existsCached = {};
  final int _maxCheckDuration = 1000 * 10;
  Future<bool> _exists(File image) async {
    int now = DateTime.now().millisecondsSinceEpoch;
    String path = image.path;
    if (_existsCached.containsKey(path) && now - _existsCached[path]! < _maxCheckDuration) {
      return true;
    }
    bool ok = await image.exists();
    if (ok) {
      _existsCached[path] = now;
    }
    return ok;
  }

  evictExistsCache(String path) {
    _existsCached.remove(path);
  }

  String _getFilePathByUrl(String url) {
    String key = _md5ByCache(url);
    String path = join(Constants.tempDir.path, key);
    return path;
  }

  File getFileByUrl(String url) {
    String path = _getFilePathByUrl(url);
    return File(path);
  }

  Future<bool> existsCachedImage(String url) async {
    File image = getFileByUrl(url);
    return _exists(image);
  }

  _download(String url) async {
    if (url.isEmpty || (!url.startsWith("http://") && !url.startsWith('https://'))) {
      _error(url);
      return;
    }
    String path = _getFilePathByUrl(url);
    String pathTemp = path + '.temp';
    File image = File(path);
    File temp = File(pathTemp);
    bool ok = true;
    if (await _exists(image) == false) {
      for (int i = 0; i < 3; i++) {
        Dio dio = Dio();
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
          client.badCertificateCallback = (X509Certificate cr, String host, int port) {
            return true;
          };
          client.findProxy = null;
        };
        try {
          
          int bodySize = 0;
          dio.options.connectTimeout = Duration(milliseconds: 5000)
          ;
          dio.options.receiveTimeout = Duration(milliseconds: 3000);
          Response res = await dio.download(url, temp.path, onReceiveProgress: (int received, int total) {
            if (bodySize != total) {
              bodySize = total;
            }
          });
          if (res.headers == null ||
              (res.headers[Headers.contentLengthHeader] != null &&
                  int.tryParse(res.headers[Headers.contentLengthHeader]![0]) != bodySize)) {
            ok = false;
          } else {
            
            await temp.rename(image.path);
            break;
          }
          
        } catch (e) {
          ok = false;

          
        }
      }
    }

    if (ok) {
      _success(url, image);
    } else {
      _error(url);
    }
  }

  _success(String url, File image) {
    if (!_res.containsKey(url)) return;
    _res[url]!.forEach((int index) {
      if (_data.containsKey(index)) {
        _data[index]!.image = image;
        _data[index]!.value = DownloadState.complete;
      }
    });
    _remove(url);
  }

  _error(String url) {
    if (!_res.containsKey(url)) return;
    _res[url]!.forEach((int index) {
      if (_data.containsKey(index)) {
        _data[index]!.image = null;
        _data[index]!.value = DownloadState.error;
      }
    });
    _remove(url);
  }

  _remove(String url) {
    if (!_res.containsKey(url)) return;
    _res[url]!.forEach((int index) {
      _data.remove(index);
    });
    _res.remove(url);
  }

  String _md5(String data) {
    final content = const Utf8Encoder().convert(data);
    final digest = md5.convert(content);
    return hex.encode(digest.bytes).toLowerCase();
  }

  remove(DownloadEntry entry) {
    int index = entry.index;
    if (_data.containsKey(index)) {
      if (_res.containsKey(entry.url)) {
        _res[entry.url]!.remove(entry.index);
      }
      if (_res.length == 0) _res.remove(entry.url);
      _data.remove(index);
      entry.dispose();
    }
  }
}
