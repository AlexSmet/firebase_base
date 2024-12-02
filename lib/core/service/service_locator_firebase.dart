import 'package:application_base/core/service/service_locator.dart';
import 'package:firebase_base/core/service/crashlytics_service.dart';
import 'package:firebase_base/core/service/firebase_messaging_service.dart';
import 'package:firebase_base/core/service/firebase_service.dart';
import 'package:firebase_base/core/service/local_notifications_service.dart';

abstract final class ServiceLocatorFirebase {
  /// Setup service locator
  static void prepare() {
    getIt
      ..registerLazySingleton<FirebaseService>(FirebaseService.new)
      ..registerLazySingleton<CrashlyticsService>(CrashlyticsService.new)
      ..registerLazySingleton<FirebaseMessagingService>(
        FirebaseMessagingService.new,
      )
      ..registerLazySingleton<LocalNotificationsService>(
        LocalNotificationsService.new,
      );
  }
}
