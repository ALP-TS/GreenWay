// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      siteCourseid: json['site_courseid'] as String?,
      relatedCourseid: json['related_courseid'] as String?,
      course: json['course'] as String?,
      subName: json['sub_name'] as String?,
      orgAmount: json['org_amount'] as String?,
      offerAmount: json['offer_amount'] as String?,
      footerTag: json['footer_tag'] as String?,
      highlight: json['highlight'] as String?,
      profile: json['profile'] as String?,
      overview: json['overview'] as String?,
      specifications: json['specifications'] as String?,
      requirements: json['requirements'] as String?,
      duration: json['duration'] as String?,
      lectures: json['lectures'] as String?,
      students: json['students'] as String?,
      language: json['language'] as String?,
      previewVideo: json['preview_video'],
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'site_courseid': instance.siteCourseid,
      'related_courseid': instance.relatedCourseid,
      'course': instance.course,
      'sub_name': instance.subName,
      'org_amount': instance.orgAmount,
      'offer_amount': instance.offerAmount,
      'footer_tag': instance.footerTag,
      'highlight': instance.highlight,
      'profile': instance.profile,
      'overview': instance.overview,
      'specifications': instance.specifications,
      'requirements': instance.requirements,
      'duration': instance.duration,
      'lectures': instance.lectures,
      'students': instance.students,
      'language': instance.language,
      'preview_video': instance.previewVideo,
    };
