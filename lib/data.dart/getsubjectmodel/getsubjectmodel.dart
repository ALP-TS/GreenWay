import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'getsubjectmodel.g.dart';

@JsonSerializable()
class Getsubjectmodel {
	String? status;
	String? message;
	List<Datum>? data;
	int? count;

	Getsubjectmodel({this.status, this.message, this.data, this.count});

	factory Getsubjectmodel.fromJson(Map<String, dynamic> json) {
		return _$GetsubjectmodelFromJson(json);
	}

	Map<String, dynamic> toJson() => _$GetsubjectmodelToJson(this);
}
