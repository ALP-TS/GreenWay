import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datumtopic {
  @JsonKey(name: 'topic_id')
  String? topicId;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'subject_id')
  String? subjectId;
  String? chapter;
  String? topics;
  String? description;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 't_count')
  int? tCount;

  Datumtopic({
    this.topicId,
    this.userId,
    this.subjectId,
    this.chapter,
    this.topics,
    this.description,
    this.createdAt,
    this.tCount,
  });

  factory Datumtopic.fromJson(Map<String, dynamic> json) =>
      _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
