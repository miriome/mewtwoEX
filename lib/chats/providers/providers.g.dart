// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationsWithStatusHash() =>
    r'7c1a04fd887fd42afff5a96075f63e69f88fa0c1';

/// See also [notificationsWithStatus].
@ProviderFor(notificationsWithStatus)
final notificationsWithStatusProvider = AutoDisposeFutureProvider<
    List<({ContactModel chat, bool unread})>>.internal(
  notificationsWithStatus,
  name: r'notificationsWithStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationsWithStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NotificationsWithStatusRef
    = AutoDisposeFutureProviderRef<List<({ContactModel chat, bool unread})>>;
String _$hasUnreadChatsHash() => r'da5e1b3aac316aca429fb512eb70705cf1da1bc9';

/// See also [hasUnreadChats].
@ProviderFor(hasUnreadChats)
final hasUnreadChatsProvider = AutoDisposeFutureProvider<bool>.internal(
  hasUnreadChats,
  name: r'hasUnreadChatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasUnreadChatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HasUnreadChatsRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
