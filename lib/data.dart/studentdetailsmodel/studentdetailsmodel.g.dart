// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studentdetailsmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Studentdetailsmodel _$StudentdetailsmodelFromJson(Map<String, dynamic> json) =>
    Studentdetailsmodel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StudentdetailsmodelToJson(
        Studentdetailsmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
