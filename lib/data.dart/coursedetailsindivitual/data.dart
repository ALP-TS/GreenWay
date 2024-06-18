import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'site_courseid')
  String? siteCourseid;
  @JsonKey(name: 'related_courseid')
  String? relatedCourseid;
  @JsonKey(name: 'course')
  String? course;
  @JsonKey(name: 'sub_name')
  String? subName;
  @JsonKey(name: 'org_amount')
  String? orgAmount;
  @JsonKey(name: 'offer_amount')
  String? offerAmount;
  @JsonKey(name: 'footer_tag')
  String? footerTag;
  @JsonKey(name: 'highlight')
  String? highlight;
  @JsonKey(name: 'profile')
  String? profile;
  @JsonKey(name: 'overview')
  String? overview;
  @JsonKey(name: 'specifications')
  String? specifications;
  @JsonKey(name: 'requirements')
  String? requirements;
  @JsonKey(name: 'duration')
  String? duration;
  @JsonKey(name: 'lectures')
  String? lectures;
  @JsonKey(name: 'students')
  String? students;
  @JsonKey(name: 'language')
  String? language;
  @JsonKey(name: 'preview_video')
  dynamic previewVideo;

  Data({
    this.siteCourseid,
    this.relatedCourseid,
    this.course,
    this.subName,
    this.orgAmount,
    this.offerAmount,
    this.footerTag,
    this.highlight,
    this.profile,
    this.overview,
    this.specifications,
    this.requirements,
    this.duration,
    this.lectures,
    this.students,
    this.language,
    this.previewVideo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
