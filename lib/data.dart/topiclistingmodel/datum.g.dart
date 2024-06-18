// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datumtopic _$DatumFromJson(Map<String, dynamic> json) => Datumtopic(
      topicId: json['topic_id'] as String?,
      userId: json['user_id'] as String?,
      subjectId: json['subject_id'] as String?,
      chapter: json['chapter'] as String?,
      topics: json['topics'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      tCount: json['t_count'] as int?,
    );

Map<String, dynamic> _$DatumToJson(Datumtopic instance) => <String, dynamic>{
      'topic_id': instance.topicId,
      'user_id': instance.userId,
      'subject_id': instance.subjectId,
      'chapter': instance.chapter,
      'topics': instance.topics,
      'description': instance.description,
      'created_at': instance.createdAt,
      't_count': instance.tCount,
    };
