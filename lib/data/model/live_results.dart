import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:liga/data/model/results.dart';

part 'live_results.g.dart';

@JsonSerializable()
class LiveResultsResponse {
  final List<Result> results;

  LiveResultsResponse(this.results);

  factory LiveResultsResponse.fromJson(Map<String, dynamic> json) => _$LiveResultsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LiveResultsResponseToJson(this);
}
