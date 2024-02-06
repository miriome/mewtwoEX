// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageHistoryHash() => r'57adb09bb063d8c93d0d89bb4862af6b6a6e5c05';

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

/// See also [messageHistory].
@ProviderFor(messageHistory)
const messageHistoryProvider = MessageHistoryFamily();

/// See also [messageHistory].
class MessageHistoryFamily extends Family<AsyncValue<List<Message>>> {
  /// See also [messageHistory].
  const MessageHistoryFamily();

  /// See also [messageHistory].
  MessageHistoryProvider call({
    required int targetId,
  }) {
    return MessageHistoryProvider(
      targetId: targetId,
    );
  }

  @override
  MessageHistoryProvider getProviderOverride(
    covariant MessageHistoryProvider provider,
  ) {
    return call(
      targetId: provider.targetId,
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
  String? get name => r'messageHistoryProvider';
}

/// See also [messageHistory].
class MessageHistoryProvider extends AutoDisposeStreamProvider<List<Message>> {
  /// See also [messageHistory].
  MessageHistoryProvider({
    required int targetId,
  }) : this._internal(
          (ref) => messageHistory(
            ref as MessageHistoryRef,
            targetId: targetId,
          ),
          from: messageHistoryProvider,
          name: r'messageHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageHistoryHash,
          dependencies: MessageHistoryFamily._dependencies,
          allTransitiveDependencies:
              MessageHistoryFamily._allTransitiveDependencies,
          targetId: targetId,
        );

  MessageHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.targetId,
  }) : super.internal();

  final int targetId;

  @override
  Override overrideWith(
    Stream<List<Message>> Function(MessageHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MessageHistoryProvider._internal(
        (ref) => create(ref as MessageHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        targetId: targetId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Message>> createElement() {
    return _MessageHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessageHistoryProvider && other.targetId == targetId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, targetId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MessageHistoryRef on AutoDisposeStreamProviderRef<List<Message>> {
  /// The parameter `targetId` of this provider.
  int get targetId;
}

class _MessageHistoryProviderElement
    extends AutoDisposeStreamProviderElement<List<Message>>
    with MessageHistoryRef {
  _MessageHistoryProviderElement(super.provider);

  @override
  int get targetId => (origin as MessageHistoryProvider).targetId;
}

String _$conversationUsersHash() => r'a2d685809a1102600027c08e7835e4805c42a67f';

/// See also [conversationUsers].
@ProviderFor(conversationUsers)
const conversationUsersProvider = ConversationUsersFamily();

/// See also [conversationUsers].
class ConversationUsersFamily
    extends Family<AsyncValue<({UserModel reciever, UserModel sender})>> {
  /// See also [conversationUsers].
  const ConversationUsersFamily();

  /// See also [conversationUsers].
  ConversationUsersProvider call({
    required int senderId,
    required int receiverId,
  }) {
    return ConversationUsersProvider(
      senderId: senderId,
      receiverId: receiverId,
    );
  }

  @override
  ConversationUsersProvider getProviderOverride(
    covariant ConversationUsersProvider provider,
  ) {
    return call(
      senderId: provider.senderId,
      receiverId: provider.receiverId,
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
  String? get name => r'conversationUsersProvider';
}

/// See also [conversationUsers].
class ConversationUsersProvider extends AutoDisposeFutureProvider<
    ({UserModel reciever, UserModel sender})> {
  /// See also [conversationUsers].
  ConversationUsersProvider({
    required int senderId,
    required int receiverId,
  }) : this._internal(
          (ref) => conversationUsers(
            ref as ConversationUsersRef,
            senderId: senderId,
            receiverId: receiverId,
          ),
          from: conversationUsersProvider,
          name: r'conversationUsersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$conversationUsersHash,
          dependencies: ConversationUsersFamily._dependencies,
          allTransitiveDependencies:
              ConversationUsersFamily._allTransitiveDependencies,
          senderId: senderId,
          receiverId: receiverId,
        );

  ConversationUsersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.senderId,
    required this.receiverId,
  }) : super.internal();

  final int senderId;
  final int receiverId;

  @override
  Override overrideWith(
    FutureOr<({UserModel reciever, UserModel sender})> Function(
            ConversationUsersRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ConversationUsersProvider._internal(
        (ref) => create(ref as ConversationUsersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        senderId: senderId,
        receiverId: receiverId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<({UserModel reciever, UserModel sender})>
      createElement() {
    return _ConversationUsersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationUsersProvider &&
        other.senderId == senderId &&
        other.receiverId == receiverId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, senderId.hashCode);
    hash = _SystemHash.combine(hash, receiverId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ConversationUsersRef
    on AutoDisposeFutureProviderRef<({UserModel reciever, UserModel sender})> {
  /// The parameter `senderId` of this provider.
  int get senderId;

  /// The parameter `receiverId` of this provider.
  int get receiverId;
}

class _ConversationUsersProviderElement
    extends AutoDisposeFutureProviderElement<
        ({UserModel reciever, UserModel sender})> with ConversationUsersRef {
  _ConversationUsersProviderElement(super.provider);

  @override
  int get senderId => (origin as ConversationUsersProvider).senderId;
  @override
  int get receiverId => (origin as ConversationUsersProvider).receiverId;
}

String _$sendTextMessageHash() => r'5187c21b0e9c8ef806e2dfaa54549d6719bbe3da';

/// See also [sendTextMessage].
@ProviderFor(sendTextMessage)
const sendTextMessageProvider = SendTextMessageFamily();

/// See also [sendTextMessage].
class SendTextMessageFamily extends Family<AsyncValue<void>> {
  /// See also [sendTextMessage].
  const SendTextMessageFamily();

  /// See also [sendTextMessage].
  SendTextMessageProvider call({
    required int senderId,
    required int receiverId,
    required String message,
  }) {
    return SendTextMessageProvider(
      senderId: senderId,
      receiverId: receiverId,
      message: message,
    );
  }

  @override
  SendTextMessageProvider getProviderOverride(
    covariant SendTextMessageProvider provider,
  ) {
    return call(
      senderId: provider.senderId,
      receiverId: provider.receiverId,
      message: provider.message,
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
  String? get name => r'sendTextMessageProvider';
}

/// See also [sendTextMessage].
class SendTextMessageProvider extends AutoDisposeFutureProvider<void> {
  /// See also [sendTextMessage].
  SendTextMessageProvider({
    required int senderId,
    required int receiverId,
    required String message,
  }) : this._internal(
          (ref) => sendTextMessage(
            ref as SendTextMessageRef,
            senderId: senderId,
            receiverId: receiverId,
            message: message,
          ),
          from: sendTextMessageProvider,
          name: r'sendTextMessageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sendTextMessageHash,
          dependencies: SendTextMessageFamily._dependencies,
          allTransitiveDependencies:
              SendTextMessageFamily._allTransitiveDependencies,
          senderId: senderId,
          receiverId: receiverId,
          message: message,
        );

  SendTextMessageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.senderId,
    required this.receiverId,
    required this.message,
  }) : super.internal();

  final int senderId;
  final int receiverId;
  final String message;

  @override
  Override overrideWith(
    FutureOr<void> Function(SendTextMessageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SendTextMessageProvider._internal(
        (ref) => create(ref as SendTextMessageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        senderId: senderId,
        receiverId: receiverId,
        message: message,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SendTextMessageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SendTextMessageProvider &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.message == message;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, senderId.hashCode);
    hash = _SystemHash.combine(hash, receiverId.hashCode);
    hash = _SystemHash.combine(hash, message.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SendTextMessageRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `senderId` of this provider.
  int get senderId;

  /// The parameter `receiverId` of this provider.
  int get receiverId;

  /// The parameter `message` of this provider.
  String get message;
}

class _SendTextMessageProviderElement
    extends AutoDisposeFutureProviderElement<void> with SendTextMessageRef {
  _SendTextMessageProviderElement(super.provider);

  @override
  int get senderId => (origin as SendTextMessageProvider).senderId;
  @override
  int get receiverId => (origin as SendTextMessageProvider).receiverId;
  @override
  String get message => (origin as SendTextMessageProvider).message;
}

String _$sendImageMessageHash() => r'cc4fc931bd31238739c1bc3b09843e0f6062b65f';

/// See also [sendImageMessage].
@ProviderFor(sendImageMessage)
const sendImageMessageProvider = SendImageMessageFamily();

/// See also [sendImageMessage].
class SendImageMessageFamily extends Family<AsyncValue<bool>> {
  /// See also [sendImageMessage].
  const SendImageMessageFamily();

  /// See also [sendImageMessage].
  SendImageMessageProvider call({
    required int senderId,
    required int receiverId,
    required XFile imageFile,
  }) {
    return SendImageMessageProvider(
      senderId: senderId,
      receiverId: receiverId,
      imageFile: imageFile,
    );
  }

  @override
  SendImageMessageProvider getProviderOverride(
    covariant SendImageMessageProvider provider,
  ) {
    return call(
      senderId: provider.senderId,
      receiverId: provider.receiverId,
      imageFile: provider.imageFile,
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
  String? get name => r'sendImageMessageProvider';
}

/// See also [sendImageMessage].
class SendImageMessageProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [sendImageMessage].
  SendImageMessageProvider({
    required int senderId,
    required int receiverId,
    required XFile imageFile,
  }) : this._internal(
          (ref) => sendImageMessage(
            ref as SendImageMessageRef,
            senderId: senderId,
            receiverId: receiverId,
            imageFile: imageFile,
          ),
          from: sendImageMessageProvider,
          name: r'sendImageMessageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sendImageMessageHash,
          dependencies: SendImageMessageFamily._dependencies,
          allTransitiveDependencies:
              SendImageMessageFamily._allTransitiveDependencies,
          senderId: senderId,
          receiverId: receiverId,
          imageFile: imageFile,
        );

  SendImageMessageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.senderId,
    required this.receiverId,
    required this.imageFile,
  }) : super.internal();

  final int senderId;
  final int receiverId;
  final XFile imageFile;

  @override
  Override overrideWith(
    FutureOr<bool> Function(SendImageMessageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SendImageMessageProvider._internal(
        (ref) => create(ref as SendImageMessageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        senderId: senderId,
        receiverId: receiverId,
        imageFile: imageFile,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _SendImageMessageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SendImageMessageProvider &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.imageFile == imageFile;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, senderId.hashCode);
    hash = _SystemHash.combine(hash, receiverId.hashCode);
    hash = _SystemHash.combine(hash, imageFile.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SendImageMessageRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `senderId` of this provider.
  int get senderId;

  /// The parameter `receiverId` of this provider.
  int get receiverId;

  /// The parameter `imageFile` of this provider.
  XFile get imageFile;
}

class _SendImageMessageProviderElement
    extends AutoDisposeFutureProviderElement<bool> with SendImageMessageRef {
  _SendImageMessageProviderElement(super.provider);

  @override
  int get senderId => (origin as SendImageMessageProvider).senderId;
  @override
  int get receiverId => (origin as SendImageMessageProvider).receiverId;
  @override
  XFile get imageFile => (origin as SendImageMessageProvider).imageFile;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
