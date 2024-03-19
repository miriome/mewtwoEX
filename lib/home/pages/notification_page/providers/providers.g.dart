// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationsWithStatusHash() =>
    r'1cf8346eb6e30ee33211f2e27c0a9b0d5b536a1a';

/// See also [notificationsWithStatus].
@ProviderFor(notificationsWithStatus)
final notificationsWithStatusProvider = AutoDisposeFutureProvider<
    List<({NotificationModel notification, bool unread})>>.internal(
  notificationsWithStatus,
  name: r'notificationsWithStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationsWithStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NotificationsWithStatusRef = AutoDisposeFutureProviderRef<
    List<({NotificationModel notification, bool unread})>>;
String _$hasUnreadNotificationsHash() =>
    r'ff1daed40828eb52aedccb34832d1fd355be11fa';

/// See also [hasUnreadNotifications].
@ProviderFor(hasUnreadNotifications)
final hasUnreadNotificationsProvider = AutoDisposeFutureProvider<bool>.internal(
  hasUnreadNotifications,
  name: r'hasUnreadNotificationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasUnreadNotificationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HasUnreadNotificationsRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
