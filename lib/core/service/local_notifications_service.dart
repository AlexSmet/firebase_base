import 'dart:async';

import 'package:firebase_base/core/entity/push_entity.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

///
typedef HandleMessage = void Function(String? message);

/// Singleton
///
/// Used only for Android
// TODO(Alex): как я понял, текущий пакет не поддерживает отображение картинок..
// Перейти на альтернативу - например
// https://pub.dev/packages/awesome_notifications
final class LocalNotificationsService {
  ///
  static const _androidIcon = '@drawable/notification';

  ///
  static const _androidInitializationSettings =
      AndroidInitializationSettings(_androidIcon);

  ///
  static const _initializationSettings = InitializationSettings(
    android: _androidInitializationSettings,
  );

  /// Channel for getting local notifications on Android
  late AndroidNotificationChannel _androidLocalChannel;

  /// Settings for local notifications on Android
  late AndroidNotificationDetails _androidLocalNotification;

  /// Local notifications instance
  final _instance = FlutterLocalNotificationsPlugin();

  /// **name** - Android application name for system notification settings
  Future<void> prepare({
    required HandleMessage handleMessage,
    required String name,
  }) async {
    /// Prepare settings
    _androidLocalChannel = AndroidNotificationChannel(
      // id
      '$name-notifications',
      // Name - в управлении уведомлениями в диспетчере приложений
      '$name Push Notification',
      description: 'Informing user',
      importance: Importance.high,
      enableLights: true,
    );

    _androidLocalNotification = AndroidNotificationDetails(
      _androidLocalChannel.id,
      _androidLocalChannel.name,
      channelDescription: _androidLocalChannel.description,
      priority: Priority.high,
      importance: Importance.high,
      setAsGroupSummary: true,
      styleInformation: const DefaultStyleInformation(true, true),
      icon: _androidIcon,
    );

    /// And customize it
    final androidPlugin = _instance.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(_androidLocalChannel);

    await _instance.initialize(
      _initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? data) =>
          handleMessage(data?.payload),
    );
  }

  /// Show local message
  Future<void> show({required PushEntity pushEntity}) => _instance.show(
        pushEntity.hashCode,
        pushEntity.title,
        pushEntity.body,
        NotificationDetails(android: _androidLocalNotification),
        payload: pushEntity.toString(),
      );
}
