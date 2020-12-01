import 'package:json_annotation/json_annotation.dart';
import 'package:liga/data/model/live_event_ui_model.dart';
import 'package:liga/data/model/results.dart';
import 'package:liga/data/model/team_ui_model.dart';

part 'match_timeline.g.dart';

@JsonSerializable()
class MatchTimelineResponse {
  @JsonKey(name: 'sport_event')
  final SportEvent sportEvent;
  final List<TimelineItem> timeline;

  MatchTimelineResponse(this.sportEvent, this.timeline);

  factory MatchTimelineResponse.fromJson(Map<String, dynamic> json) => _$MatchTimelineResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MatchTimelineResponseToJson(this);
}

@JsonSerializable()
class TimelineItem {
  final int id;
  final String type;
  final List<Commentary> commentaries;
  final String team;
  final Player player;

  @JsonKey(name: 'match_time')
  final int matchTime;

  @JsonKey(name: 'goal_scorer')
  final GoalScorer goalScorer;

  TimelineItem(this.id, this.type, this.commentaries, this.team, this.matchTime, this.player, this.goalScorer);

  factory TimelineItem.fromJson(Map<String, dynamic> json) => _$TimelineItemFromJson(json);

  Map<String, dynamic> toJson() => _$TimelineItemToJson(this);

  LiveEventType getLiveEventType() {
    LiveEventType eventType;
    switch (type) {
      case 'match_started':
        {
          eventType = LiveEventType.matchStarted;
        }
        break;
      case 'match_ended':
        {
          eventType = LiveEventType.matchEnded;
        }
        break;
      case 'period_start':
        {
          eventType = LiveEventType.periodStart;
        }
        break;
      case 'break_start':
        {
          eventType = LiveEventType.breakStart;
        }
        break;
      case 'throw_in':
        {
          eventType = LiveEventType.throwIn;
        }
        break;
      case 'free_kick':
        {
          eventType = LiveEventType.freeKick;
        }
        break;
      case 'goal_kick':
        {
          eventType = LiveEventType.goalKick;
        }
        break;
      case 'corner_kick':
        {
          eventType = LiveEventType.cornerKick;
        }
        break;
      case 'score_change':
        {
          eventType = LiveEventType.scoreChange;
        }
        break;
      case 'yellow_card':
        {
          eventType = LiveEventType.yellowCard;
        }
        break;
      case 'red_card':
        {
          eventType = LiveEventType.redCard;
        }
        break;
      case 'shot_off_target':
        {
          eventType = LiveEventType.shotOffTarget;
        }
        break;
      case 'shot_on_target':
        {
          eventType = LiveEventType.shotOnTarget;
        }
        break;
      case 'shot_saved':
        {
          eventType = LiveEventType.shotSaved;
        }
        break;
      case 'offside':
        {
          eventType = LiveEventType.offside;
        }
        break;
      case 'injury':
        {
          eventType = LiveEventType.injury;
        }
        break;
      case 'injury_return':
        {
          eventType = LiveEventType.injuryReturn;
        }
        break;
      case 'injury_time_shown':
        {
          eventType = LiveEventType.injuryTimeShown;
        }
        break;
      default:
        {
          eventType = LiveEventType.unknown;
        }
        break;
    }
    return eventType;
  }

  TeamType getTeamType() {
    TeamType teamType;
    switch (team) {
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
class Commentary {
  final String text;

  Commentary(this.text);

  factory Commentary.fromJson(Map<String, dynamic> json) => _$CommentaryFromJson(json);

  Map<String, dynamic> toJson() => _$CommentaryToJson(this);
}

@JsonSerializable()
class GoalScorer {
  final String id;
  final String name;

  GoalScorer(this.id, this.name);

  factory GoalScorer.fromJson(Map<String, dynamic> json) => _$GoalScorerFromJson(json);

  Map<String, dynamic> toJson() => _$GoalScorerToJson(this);
}

@JsonSerializable()
class Player {
  final String id;
  final String name;

  Player(this.id, this.name);

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
