// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      studentId: json['student_id'] as String?,
      userId: json['user_id'] as String?,
      classId: json['class_id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      expireDate: json['expire_date'] as String?,
      seenVideo: json['seen_video'] as String?,
      seenNote: json['seen_note'] as String?,
      seenAudio: json['seen_audio'] as String?,
      ip: json['ip'] as String?,
      deviceId: json['device_id'] as String?,
      status: json['status'] as String?,
      utype: json['utype'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'student_id': instance.studentId,
      'user_id': instance.userId,
      'class_id': instance.classId,
      'name': instance.name,
      'phone': instance.phone,
      'expire_date': instance.expireDate,
      'seen_video': instance.seenVideo,
      'seen_note': instance.seenNote,
      'seen_audio': instance.seenAudio,
      'ip': instance.ip,
      'device_id': instance.deviceId,
      'status': instance.status,
      'utype': instance.utype,
    };
