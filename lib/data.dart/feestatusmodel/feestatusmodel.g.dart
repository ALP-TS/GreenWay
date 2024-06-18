// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feestatusmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feestatusmodel _$FeestatusmodelFromJson(Map<String, dynamic> json) =>
    Feestatusmodel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeestatusmodelToJson(Feestatusmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
