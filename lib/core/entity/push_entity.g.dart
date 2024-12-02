// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushEntity _$PushEntityFromJson(Map<String, dynamic> json) => PushEntity()
  ..category = json['category'] as String?
  ..from = json['from'] as String?
  ..messageId = json['messageId'] as String?
  ..messageType = json['messageType'] as String?
  ..title = json['title'] as String?
  ..body = json['body'] as String?
  ..sentTime = json['sentTime'] == null
      ? null
      : DateTime.parse(json['sentTime'] as String)
  ..contentAvailable = json['contentAvailable'] as bool?
  ..data = json['data'] as Map<String, dynamic>?;

Map<String, dynamic> _$PushEntityToJson(PushEntity instance) =>
    <String, dynamic>{
      'category': instance.category,
      'from': instance.from,
      'messageId': instance.messageId,
      'messageType': instance.messageType,
      'title': instance.title,
      'body': instance.body,
      'sentTime': instance.sentTime?.toIso8601String(),
      'contentAvailable': instance.contentAvailable,
      'data': instance.data,
    };
