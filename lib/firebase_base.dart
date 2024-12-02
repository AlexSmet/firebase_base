import 'package:application_base/core/service/service_locator.dart';
import 'package:firebase_base/core/service/firebase_messaging_service.dart';
import 'package:firebase_base/core/service/firebase_service.dart';
import 'package:firebase_base/core/service/service_locator_firebase.dart';
import 'package:firebase_core/firebase_core.dart';

abstract final class FirebaseBase {
  /// **name** - Android application name for system notification settings
  ///
  /// **options** - Specific Firebase configuration options depends on current
  /// platform and flavor
  static Future<void> prepare({
    required String name,
    FirebaseOptions? options,
  }) async {
    /// Setup service locator
    ServiceLocatorFirebase.prepare();

    /// Prepare all Firebase packages
    await getIt<FirebaseService>().prepare(options: options);

    ///
    await getIt<FirebaseMessagingService>().prepare(name: name);
  }
}
