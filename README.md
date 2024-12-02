<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Unified base Firebase integration for Flutter applications based on 
[application_base package](https://github.com/AlexSeednov/application_base)
with 
[special architecture](https://miro.com/app/board/uXjVNJVBM3o=/?share_link_id=771428578014)

## Features

TODO: 

All four services are **Singleton** and available via **GetIt**.

FCM Device token available via **FirebaseMessagingService->token**.

Example

```dart
getIt<FirebaseMessagingService>().token;
```

To get data from Push's payload you need to listen `pushSubject` stream. 
On listening this stream will return previous payload if it was.
Payload - `Map<String, dynamic>`

Example:

```dart
// TODO
```

// в app/src/main/res/drawable - notification.png
  // и в app/src/main/res/drawable-v21 - notification.png

**Important** do not forget to ask user notifications permission via
`FirebaseMessagingService->requestPermission`.

Example

```dart
final status = await getIt<FirebaseMessagingService>().requestPermission();
```

It's better for UX to call in once on user Authorization / Registration only.

## Usage

TODO: 
