import 'dart:async';

import 'package:application_base/core/service/logger_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_base/core/entity/push_entity.dart';

///
typedef HandleMessage = void Function(Map<String, String?>? message);

/// Singleton
///
/// Used only for Android
final class LocalNotificationsService {
  /// Channel for getting local notifications on Android
  late NotificationChannel _androidLocalChannel;

  /// Local notifications instance
  final _instance = AwesomeNotifications();

  ///
  static HandleMessage? _handleMessage;

  /// **name** - Android application name for system notification settings
  Future<void> prepare({
    required HandleMessage handleMessage,
    required String name,
  }) async {
    _handleMessage = handleMessage;

    /// Prepare settings
    _androidLocalChannel = NotificationChannel(
      channelGroupKey: '$name-notifications-group',
      channelKey: '$name-notifications',
      channelName: '$name Push Notification',
      channelDescription: 'Notification channel for informing user',
      importance: NotificationImportance.Max,
    );

    await _instance.initialize(
      // Use default application icon
      null,
      [_androidLocalChannel],
    );

    await _instance.setListeners(
      onActionReceivedMethod: _onActionReceivedMethod,
    );
  }

  /// Show local message
  Future<bool> show({required PushEntity pushEntity, String? picture}) =>
      _instance.createNotification(
        content: NotificationContent(
          id: pushEntity.hashCode,
          channelKey: _androidLocalChannel.channelKey!,
          title: pushEntity.title,
          body: pushEntity.body,
          payload: pushEntity.toMap(),
          largeIcon: picture,
        ),
      );

  /// Use this method to detect when the user taps on a notification
  /// or action button
  ///
  /// Must be a static
  ///
  /// Need to use @pragma("vm:entry-point") in each static method to identify
  /// to the Flutter engine that the dart address will be called from native
  /// and should be preserved
  @pragma('vm:entry-point')
  static Future<void> _onActionReceivedMethod(
    ReceivedAction data,
  ) async {
    logInfo(info: 'Push in Foreground state tapped');
    _handleMessage?.call(data.payload);
  }
}
