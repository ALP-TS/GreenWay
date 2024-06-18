// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coursedetailsindivitual.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coursedetailsindivitual _$CoursedetailsindivitualFromJson(
        Map<String, dynamic> json) =>
    Coursedetailsindivitual(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CoursedetailsindivitualToJson(
        Coursedetailsindivitual instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
