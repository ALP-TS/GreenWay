import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'studentdetailsmodel.g.dart';

@JsonSerializable()
class Studentdetailsmodel {
	String? status;
	String? message;
	Data? data;

	Studentdetailsmodel({this.status, this.message, this.data});

	factory Studentdetailsmodel.fromJson(Map<String, dynamic> json) {
		return _$StudentdetailsmodelFromJson(json);
	}

	Map<String, dynamic> toJson() => _$StudentdetailsmodelToJson(this);
}
