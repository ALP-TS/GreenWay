import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'coursedetailsindivitual.g.dart';

@JsonSerializable()
class Coursedetailsindivitual {
	String? status;
	String? message;
	Data? data;

	Coursedetailsindivitual({this.status, this.message, this.data});

	factory Coursedetailsindivitual.fromJson(Map<String, dynamic> json) {
		return _$CoursedetailsindivitualFromJson(json);
	}

	Map<String, dynamic> toJson() => _$CoursedetailsindivitualToJson(this);
}
