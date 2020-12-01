import 'package:json_annotation/json_annotation.dart';
import 'package:liga/data/enum.dart';
import 'package:liga/data/model/team_ui_model.dart';

part 'results.g.dart';

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
  final String id;
  final List<Competitor> competitors;

  SportEvent(this.id, this.competitors);

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

  TeamType getTeamType() {
    TeamType teamType;
    switch (qualifier) {
      case 'home':
        {
          teamType = TeamType.home;
        }
        break;
      case 'away':
        {
          teamType = TeamType.away;
        }
        break;
      default:
        {
          teamType = TeamType.unknown;
        }
        break;
    }
    return teamType;
  }
}

@JsonSerializable()
class SportEventStatus {
  final String status;

  @JsonKey(name: 'home_score')
  final int homeScore;

  @JsonKey(name: 'away_score')
  final int awayScore;

  @JsonKey(name: 'winner_id')
  final String winnerId;

  SportEventStatus(this.status, this.homeScore, this.awayScore, this.winnerId);

  factory SportEventStatus.fromJson(Map<String, dynamic> json) => _$SportEventStatusFromJson(json);

  Map<String, dynamic> toJson() => _$SportEventStatusToJson(this);

  bool isLive() {
    return status == 'live';
  }
}

class MatchResult extends Enum<String> {
  const MatchResult(String value) : super(value);

  static const win = const MatchResult('В');
  static const lose = const MatchResult('П');
  static const draw = const MatchResult('Н');
}
