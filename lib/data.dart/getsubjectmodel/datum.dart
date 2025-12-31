import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum {
  @JsonKey(name: 'subject_id')
  String? subjectId;
  @JsonKey(name: 'class_id')
  String? classId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'created_at')
  String? createdAt;
  String? url;
  @JsonKey(name: 't_count')
  int? tCount;

  Datum({
    this.subjectId,
    this.classId,
    this.name,
    this.createdAt,
    this.url,
    this.tCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
