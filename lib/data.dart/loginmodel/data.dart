import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'student_id')
  String? studentId;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'class_id')
  String? classId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'expire_date')
  String? expireDate;
  @JsonKey(name: 'seen_video')
  String? seenVideo;
  @JsonKey(name: 'seen_note')
  String? seenNote;
  @JsonKey(name: 'seen_audio')
  String? seenAudio;
  String? ip;
  @JsonKey(name: 'device_id')
  String? deviceId;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'utype')
  String? utype;

  Data({
    this.studentId,
    this.userId,
    this.classId,
    this.name,
    this.phone,
    this.expireDate,
    this.seenVideo,
    this.seenNote,
    this.seenAudio,
    this.ip,
    this.deviceId,
    this.status,
    this.utype,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
