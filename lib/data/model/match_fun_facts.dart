import 'package:json_annotation/json_annotation.dart';
import 'package:liga/data/model/team_results.dart';

part 'match_fun_facts.g.dart';

@JsonSerializable()
class MatchFunFactsResponse {
  final SportEvent sportEvent;
  final List<Fact> facts;

  MatchFunFactsResponse(this.sportEvent, this.facts);

  factory MatchFunFactsResponse.fromJson(Map<String, dynamic> json) => _$MatchFunFactsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MatchFunFactsResponseToJson(this);
}

@JsonSerializable()
class Fact {
  final String statement;

  Fact(this.statement);

  factory Fact.fromJson(Map<String, dynamic> json) => _$FactFromJson(json);

  Map<String, dynamic> toJson() => _$FactToJson(this);
}
