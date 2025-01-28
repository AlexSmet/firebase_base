import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_entity.g.dart';

/// Getted push data
@JsonSerializable(createFactory: true, createToJson: true)
final class PushEntity {
  ///
  PushEntity();

  ///
  factory PushEntity.fromMessage(RemoteMessage message) => PushEntity()
    ..category = message.category
    ..from = message.from
    ..messageId = message.messageId
    ..messageType = message.messageType
    ..title = message.notification?.title ?? ''
    ..body = message.notification?.body ?? ''
    ..sentTime = message.sentTime
    ..contentAvailable = message.contentAvailable
    ..data = message.data;

  /// Convert data from JSON
  factory PushEntity.fromJson(Map<String, dynamic> json) =>
      _$PushEntityFromJson(json);

  /// Parse data from JSON string
  factory PushEntity.fromString(String data) =>
      PushEntity.fromJson(jsonDecode(data) as Map<String, dynamic>);

  ///
  @JsonKey(name: 'category')
  String? category;

  ///
  @JsonKey(name: 'from')
  String? from;

  ///
  @JsonKey(name: 'messageId')
  String? messageId;

  ///
  @JsonKey(name: 'messageType')
  String? messageType;

  ///
  @JsonKey(name: 'title')
  String? title;

  ///
  @JsonKey(name: 'body')
  String? body;

  ///
  @JsonKey(name: 'sentTime')
  DateTime? sentTime;

  ///
  @JsonKey(name: 'contentAvailable')
  bool? contentAvailable;

  ///
  @JsonKey(name: 'data')
  Map<String, dynamic>? data;

  /// Convert data to Json
  Map<String, dynamic> toJson() => _$PushEntityToJson(this);

  /// Convert data to String map
  Map<String, String?> toMap() {
    final Map<String, String?> result = {};

    toJson().forEach((key, value) {
      if (value == null) {
        result[key] = null;
      } else if (value is String) {
        result[key] = value;
      } else {
        result[key] = value.toString();
      }
    });

    return result;
  }

  /// Convert data to String in JSON format
  @override
  String toString() => json.encode(toJson());
}
