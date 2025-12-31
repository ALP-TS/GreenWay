// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topiclistingmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topiclistingmodel _$TopiclistingmodelFromJson(Map<String, dynamic> json) =>
    Topiclistingmodel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datumtopic.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$TopiclistingmodelToJson(Topiclistingmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'count': instance.count,
    };
