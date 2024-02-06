// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getContactsApiHash() => r'd4a13c39354b39d0ca065f39723f7350a6451666';

/// See also [getContactsApi].
@ProviderFor(getContactsApi)
final getContactsApiProvider =
    AutoDisposeFutureProvider<List<ContactModel>>.internal(
  getContactsApi,
  name: r'getContactsApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getContactsApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetContactsApiRef = AutoDisposeFutureProviderRef<List<ContactModel>>;
String _$sendMessageApiHash() => r'2a2d84194ffa0854585407deb248e2d7ca520ef6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [sendMessageApi].
@ProviderFor(sendMessageApi)
const sendMessageApiProvider = SendMessageApiFamily();

/// See also [sendMessageApi].
class SendMessageApiFamily extends Family<AsyncValue<bool>> {
  /// See also [sendMessageApi].
  const SendMessageApiFamily();

  /// See also [sendMessageApi].
  SendMessageApiProvider call({
    required int receiverId,
    required String message,
    required String messageType,
  }) {
    return SendMessageApiProvider(
      receiverId: receiverId,
      message: message,
      messageType: messageType,
    );
  }

  @override
  SendMessageApiProvider getProviderOverride(
    covariant SendMessageApiProvider provider,
  ) {
    return call(
      receiverId: provider.receiverId,
      message: provider.message,
      messageType: provider.messageType,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sendMessageApiProvider';
}

/// See also [sendMessageApi].
class SendMessageApiProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [sendMessageApi].
  SendMessageApiProvider({
    required int receiverId,
    required String message,
    required String messageType,
  }) : this._internal(
          (ref) => sendMessageApi(
            ref as SendMessageApiRef,
            receiverId: receiverId,
            message: message,
            messageType: messageType,
          ),
          from: sendMessageApiProvider,
          name: r'sendMessageApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sendMessageApiHash,
          dependencies: SendMessageApiFamily._dependencies,
          allTransitiveDependencies:
              SendMessageApiFamily._allTransitiveDependencies,
          receiverId: receiverId,
          message: message,
          messageType: messageType,
        );

  SendMessageApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.receiverId,
    required this.message,
    required this.messageType,
  }) : super.internal();

  final int receiverId;
  final String message;
  final String messageType;

  @override
  Override overrideWith(
    FutureOr<bool> Function(SendMessageApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SendMessageApiProvider._internal(
        (ref) => create(ref as SendMessageApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        receiverId: receiverId,
        message: message,
        messageType: messageType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _SendMessageApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SendMessageApiProvider &&
        other.receiverId == receiverId &&
        other.message == message &&
        other.messageType == messageType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, receiverId.hashCode);
    hash = _SystemHash.combine(hash, message.hashCode);
    hash = _SystemHash.combine(hash, messageType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SendMessageApiRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `receiverId` of this provider.
  int get receiverId;

  /// The parameter `message` of this provider.
  String get message;

  /// The parameter `messageType` of this provider.
  String get messageType;
}

class _SendMessageApiProviderElement
    extends AutoDisposeFutureProviderElement<bool> with SendMessageApiRef {
  _SendMessageApiProviderElement(super.provider);

  @override
  int get receiverId => (origin as SendMessageApiProvider).receiverId;
  @override
  String get message => (origin as SendMessageApiProvider).message;
  @override
  String get messageType => (origin as SendMessageApiProvider).messageType;
}

String _$uploadImageApiHash() => r'95cb1049ee2875326b9d958d6784b987a3774446';

/// See also [uploadImageApi].
@ProviderFor(uploadImageApi)
const uploadImageApiProvider = UploadImageApiFamily();

/// See also [uploadImageApi].
class UploadImageApiFamily extends Family<AsyncValue<String?>> {
  /// See also [uploadImageApi].
  const UploadImageApiFamily();

  /// See also [uploadImageApi].
  UploadImageApiProvider call({
    required XFile image,
  }) {
    return UploadImageApiProvider(
      image: image,
    );
  }

  @override
  UploadImageApiProvider getProviderOverride(
    covariant UploadImageApiProvider provider,
  ) {
    return call(
      image: provider.image,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'uploadImageApiProvider';
}

/// See also [uploadImageApi].
class UploadImageApiProvider extends AutoDisposeFutureProvider<String?> {
  /// See also [uploadImageApi].
  UploadImageApiProvider({
    required XFile image,
  }) : this._internal(
          (ref) => uploadImageApi(
            ref as UploadImageApiRef,
            image: image,
          ),
          from: uploadImageApiProvider,
          name: r'uploadImageApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$uploadImageApiHash,
          dependencies: UploadImageApiFamily._dependencies,
          allTransitiveDependencies:
              UploadImageApiFamily._allTransitiveDependencies,
          image: image,
        );

  UploadImageApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.image,
  }) : super.internal();

  final XFile image;

  @override
  Override overrideWith(
    FutureOr<String?> Function(UploadImageApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UploadImageApiProvider._internal(
        (ref) => create(ref as UploadImageApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        image: image,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _UploadImageApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UploadImageApiProvider && other.image == image;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, image.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UploadImageApiRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `image` of this provider.
  XFile get image;
}

class _UploadImageApiProviderElement
    extends AutoDisposeFutureProviderElement<String?> with UploadImageApiRef {
  _UploadImageApiProviderElement(super.provider);

  @override
  XFile get image => (origin as UploadImageApiProvider).image;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
