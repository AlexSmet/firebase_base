import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_base/core/entity/push_entity.dart';

///
typedef HandleMessage = void Function(String? message);

/// Singleton
///
/// Used only for Android
final class LocalNotificationsService {
  /// Channel for getting local notifications on Android
  late NotificationChannel _androidLocalChannel;

  /// Local notifications instance
  final _instance = AwesomeNotifications();

  /// **name** - Android application name for system notification settings
  Future<void> prepare({
    required HandleMessage handleMessage,
    required String name,
  }) async {
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
      onActionReceivedMethod: (ReceivedAction data) async =>
          handleMessage(data.body),
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
}
