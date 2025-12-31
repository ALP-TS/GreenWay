// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      subjectId: json['subject_id'] as String?,
      classId: json['class_id'] as String?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      url: json['url'] as String?,
      tCount: json['t_count'] as int?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'subject_id': instance.subjectId,
      'class_id': instance.classId,
      'name': instance.name,
      'created_at': instance.createdAt,
      'url': instance.url,
      't_count': instance.tCount,
    };
