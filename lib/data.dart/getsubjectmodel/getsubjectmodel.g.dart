// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getsubjectmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getsubjectmodel _$GetsubjectmodelFromJson(Map<String, dynamic> json) =>
    Getsubjectmodel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$GetsubjectmodelToJson(Getsubjectmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'count': instance.count,
    };
