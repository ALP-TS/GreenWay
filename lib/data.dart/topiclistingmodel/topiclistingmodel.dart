import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'topiclistingmodel.g.dart';

@JsonSerializable()
class Topiclistingmodel {
  String? status;
  String? message;
  List<Datumtopic>? data;
  int? count;

  Topiclistingmodel({this.status, this.message, this.data, this.count});

  factory Topiclistingmodel.fromJson(Map<String, dynamic> json) {
    return _$TopiclistingmodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TopiclistingmodelToJson(this);
}
