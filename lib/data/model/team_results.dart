import 'package:json_annotation/json_annotation.dart';
import 'package:liga/data/model/results.dart';

part 'team_results.g.dart';

@JsonSerializable()
class TeamResultsResponse {
  final Team team;
  final List<Result> results;

  TeamResultsResponse(this.team, this.results);

  factory TeamResultsResponse.fromJson(Map<String, dynamic> json) => _$TeamResultsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TeamResultsResponseToJson(this);
}
