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
	String? name;
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
	String? status;

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
	});

	factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

	Map<String, dynamic> toJson() => _$DataToJson(this);
}
