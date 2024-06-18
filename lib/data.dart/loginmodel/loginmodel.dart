import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'loginmodel.g.dart';

@JsonSerializable()
class Loginmodel {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  Data? data;

  Loginmodel({this.status, this.message, this.data});

  factory Loginmodel.fromJson(Map<String, dynamic> json) {
    return _$LoginmodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginmodelToJson(this);
}
