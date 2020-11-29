import 'package:json_annotation/json_annotation.dart';

part 'team_results.g.dart';

@JsonSerializable()
class TeamResults {
  final Team team;
  final List<Result> results;

  TeamResults(this.team, this.results);

  factory TeamResults.fromJson(Map<String, dynamic> json) => _$TeamResultsFromJson(json);

  Map<String, dynamic> toJson() => _$TeamResultsToJson(this);
}

@JsonSerializable()
class Team {
  final String id;
  final String name;

  Team(this.id, this.name);

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: 'sport_event')
  final SportEvent sportEvent;
  @JsonKey(name: 'sport_event_status')
  final SportEventStatus sportEventStatus;

  Result(this.sportEvent, this.sportEventStatus);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class SportEvent {
  final List<Competitor> competitors;

  SportEvent(this.competitors);

  factory SportEvent.fromJson(Map<String, dynamic> json) => _$SportEventFromJson(json);

  Map<String, dynamic> toJson() => _$SportEventToJson(this);
}

@JsonSerializable()
class Competitor {
  final String id;
  final String name;
  final String country;
  final String qualifier;

  Competitor(this.id, this.name, this.country, this.qualifier);

  factory Competitor.fromJson(Map<String, dynamic> json) => _$CompetitorFromJson(json);

  Map<String, dynamic> toJson() => _$CompetitorToJson(this);
}

@JsonSerializable()
class SportEventStatus {
  final String status;

  @JsonKey(name: 'home_score')
  final int homeScore;

  @JsonKey(name: 'away_score')
  final int awayScore;

  SportEventStatus(this.status, this.homeScore, this.awayScore);

  factory SportEventStatus.fromJson(Map<String, dynamic> json) => _$SportEventStatusFromJson(json);

  Map<String, dynamic> toJson() => _$SportEventStatusToJson(this);
}
