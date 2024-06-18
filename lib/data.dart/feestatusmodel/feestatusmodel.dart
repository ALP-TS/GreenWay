import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'feestatusmodel.g.dart';

@JsonSerializable()
class Feestatusmodel {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  Data? data;

  Feestatusmodel({this.status, this.message, this.data});

  factory Feestatusmodel.fromJson(Map<String, dynamic> json) {
    return _$FeestatusmodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FeestatusmodelToJson(this);
}
