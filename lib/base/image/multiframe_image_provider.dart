import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui' as ui;

/// 可以控制大的动图播放完，不存储在memory cache
abstract class MultiFrameImageProvider<T extends Object> extends ImageProvider<T>{

  bool needMemoryCache = true;

  int frameCount = 1;

  MultiFrameImageProvider({this.needMemoryCache = false});

  @override
  void resolveStreamForKey(ImageConfiguration configuration, ImageStream stream, T key, ImageErrorListener handleError) {
    if(needMemoryCache){
      super.resolveStreamForKey(configuration, stream, key, handleError);
    }else{
      if (stream.completer == null) {
        final ImageStreamCompleter completer = loadBuffer(
            key, PaintingBinding.instance.instantiateImageCodecFromBuffer);
        if (completer != null) {
          stream.setCompleter(completer);
        }
      }
    }
  }
}

/// Assets
class MultiFrameAssetImageProvider extends MultiFrameImageProvider<MultiFrameAssetImageProvider>{

  final String assets;
  final AssetBundle? bundle;

  MultiFrameAssetImageProvider({required this.assets, this.bundle,bool needMemoryCache=true}):super(needMemoryCache:false);

  @override
  ImageStreamCompleter loadBuffer(MultiFrameAssetImageProvider key, DecoderBufferCallback decode){
    final StreamController<ImageChunkEvent> chunkEvents = StreamController<ImageChunkEvent>();

    return BBMultiFrameImageStreamCompleter(
      codec: _loadAsync(key, chunkEvents, decode),
      chunkEvents: chunkEvents.stream,
      scale: 1.0,
      debugLabel: assets,
      frameCountSetter: (count) => frameCount = count,
      informationCollector: () {
        return <DiagnosticsNode>[
          DiagnosticsProperty<ImageProvider>('Image provider', this),
          DiagnosticsProperty<MultiFrameAssetImageProvider>('Image key', key),
        ];
      },
    );
  }

  @override
  Future<MultiFrameAssetImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<MultiFrameAssetImageProvider>(this);
  }

  Future<ui.Codec> _loadAsync(
      MultiFrameAssetImageProvider key,
      StreamController<ImageChunkEvent> chunkEvents,
      DecoderBufferCallback decode) async {
    try {
      chunkEvents?.add(ImageChunkEvent(cumulativeBytesLoaded: 0, expectedTotalBytes: 100));
      final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromAsset(key.assets);
      chunkEvents?.add(ImageChunkEvent(cumulativeBytesLoaded: 100, expectedTotalBytes: 100));
      return decode(buffer);
    } catch (e) {
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      rethrow;
    } finally {
      chunkEvents?.close();
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiFrameAssetImageProvider &&
          runtimeType == other.runtimeType &&
          assets == other.assets &&
          bundle == other.bundle;

  @override
  int get hashCode => assets.hashCode ^ bundle.hashCode;
}

/// File
class MultiFrameFileImageProvider extends MultiFrameImageProvider<MultiFrameFileImageProvider>{

  final File file;

  MultiFrameFileImageProvider({required this.file,bool needMemoryCache=true}):super(needMemoryCache: needMemoryCache);

  @override
  ImageStreamCompleter loadBuffer(MultiFrameFileImageProvider key, DecoderBufferCallback decode) {
    final StreamController<ImageChunkEvent> chunkEvents = StreamController<ImageChunkEvent>();

    return BBMultiFrameImageStreamCompleter(
      codec: _loadAsync(key, chunkEvents, decode),
      chunkEvents: chunkEvents.stream,
      scale: 1.0,
      debugLabel: file?.path,
      frameCountSetter: (count) => frameCount = count,
      informationCollector: () {
        return <DiagnosticsNode>[
          DiagnosticsProperty<ImageProvider>('Image provider', this),
          DiagnosticsProperty<MultiFrameFileImageProvider>('Image key', key),
        ];
      },
    );
  }

  Future<ui.Codec> _loadAsync(MultiFrameFileImageProvider key,StreamController<ImageChunkEvent> chunkEvents,DecoderBufferCallback decode) async {
    assert(key == this);
    try{
      chunkEvents?.add(ImageChunkEvent(cumulativeBytesLoaded: 0, expectedTotalBytes: 100));
      final Uint8List bytes = await file.readAsBytes();
      if (bytes.lengthInBytes == 0) {
        // The file may become available later.
        PaintingBinding.instance.imageCache.evict(key);
      }
      final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
      chunkEvents?.add(ImageChunkEvent(cumulativeBytesLoaded: 100, expectedTotalBytes: 100));
      return decode(buffer);
    }catch(e){
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      rethrow;
    }finally {
      chunkEvents?.close();
    }
  }

  @override
  Future<MultiFrameFileImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<MultiFrameFileImageProvider>(this);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiFrameFileImageProvider &&
          runtimeType == other.runtimeType &&
          file == other.file;

  @override
  int get hashCode => file.hashCode;
}

/// NetWorkImage use [BBCachedNetworkImageProvider]

class BBMultiFrameImageStreamCompleter extends MultiFrameImageStreamCompleter{
  BBMultiFrameImageStreamCompleter({
    required Future<ui.Codec> codec,
    required double scale,
    String? debugLabel,
    Stream<ImageChunkEvent>? chunkEvents,
    InformationCollector? informationCollector,
    ValueSetter<int>? frameCountSetter,
  }):super(
    codec: codec,
    scale: scale,
    debugLabel: debugLabel,
    chunkEvents: chunkEvents,
    informationCollector: informationCollector
  ){
    if(frameCountSetter != null){
      codec.then((value) => frameCountSetter(value.frameCount));
    }
  }
}