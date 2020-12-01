import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:liga/data/model/live_event_ui_model.dart';

// ignore: unused_import
import 'package:liga/data/model/live_results.dart';
import 'package:liga/data/model/live_widget_ui_model.dart';
import 'package:liga/data/model/match_timeline.dart';
import 'package:liga/data/model/results.dart';
import 'package:liga/data/model/team_ui_model.dart';
import 'package:liga/feature/widget/sport_widget_state.dart';
import 'package:liga/net/network_client.dart';

import '../../config.dart';

class LiveDataRepository {
  // ignore: unused_field
  final NetworkClient _networkClient;

  // ignore: unused_field
  final Config _config;

  static LiveDataRepository _instance;

  MatchTimelineResponse _timelineResponse;
  int _timelineItemsIndex = 0;

  factory LiveDataRepository(networkClient, config) {
    return _instance ?? LiveDataRepository._internal(networkClient, config);
  }

  LiveDataRepository._internal(this._networkClient, this._config) {
    _instance = this;
  }

  Future<LiveWidgetUiModel> getLiveData() async {
    // uncomment this block and remove response json when want going to use backend
    /*String apiKey = await _config.getApiKey();
    LiveResultsResponse response = await _networkClient.getLiveResults(apiKey);
    String matchId = response.results.first.sportEvent.id;
    MatchTimelineResponse timelineResponse = await _networkClient.getMatchTimeLine(matchId, apiKey);*/
    MatchTimelineResponse timelineResponse = await _getMatchTimeLineResponseFromAssets();
    List<TimelineItem> timelineItems = _getTimelineItems(timelineResponse.timeline);
    return _mapToUiModel(timelineResponse, timelineItems);
  }

  Future<MatchTimelineResponse> _getMatchTimeLineResponseFromAssets() async {
    if (_timelineResponse == null) {
      final String content = await rootBundle.loadString('assets/MatchTimelineResponse.json');
      final json = jsonDecode(content);
      _timelineResponse = MatchTimelineResponse.fromJson(json);
    }
    return _timelineResponse;
  }

  List<TimelineItem> _getTimelineItems(List<TimelineItem> timelineItems) {
    List<TimelineItem> result = List<TimelineItem>();
    if (_timelineItemsIndex <= timelineItems.length - 1) {
      for (int i = 0; i <= _timelineItemsIndex; i++) {
        result.add(timelineItems[i]);
      }
      _timelineItemsIndex++;
    } else {
      result.addAll(timelineItems);
    }
    return result;
  }

  LiveWidgetUiModel _mapToUiModel(MatchTimelineResponse timelineResponse, List<TimelineItem> timelineItems) {
    int homeTeamGoals = 0;
    int awayTeamGoals = 0;

    int homeTeamCornerKicks = 0;
    int awayTeamCornerKicks = 0;

    int homeTeamYellowCards = 0;
    int awayTeamYellowCards = 0;

    int homeTeamRedCards = 0;
    int awayTeamRedCards = 0;

    int homeTeamOffsides = 0;
    int awayTeamOffsides = 0;

    int homeTeamThrowIns = 0;
    int awayTeamThrowIns = 0;

    List<LiveEventUiModel> eventUiModels = List<LiveEventUiModel>();
    if (timelineItems != null && timelineItems.isNotEmpty) {
      List<TimelineItem> reversedItems = List.from(timelineItems.reversed);
      reversedItems.forEach((timelineItem) {
        final model = LiveEventUiModel(
            timelineItem.id, timelineItem.getLiveEventType(), timelineItem.matchTime.toString(), timelineItem.getTeamType(),
            goalScorer: timelineItem.goalScorer, player: timelineItem.player);
        eventUiModels.add(model);

        final LiveEventType eventType = timelineItem.getLiveEventType();
        final TeamType teamType = timelineItem.getTeamType();

        if (LiveEventType.scoreChange == eventType) {
          if (TeamType.home == teamType) {
            homeTeamGoals += timelineItem.homeScore;
          } else if (TeamType.away == teamType) {
            awayTeamGoals += timelineItem.awayScore;
          }
        }

        if (LiveEventType.cornerKick == eventType) {
          if (TeamType.home == teamType) {
            homeTeamCornerKicks++;
          } else if (TeamType.away == teamType) {
            awayTeamCornerKicks++;
          }
        }

        if (LiveEventType.yellowCard == eventType) {
          if (TeamType.home == teamType) {
            homeTeamYellowCards++;
          } else if (TeamType.away == teamType) {
            awayTeamYellowCards++;
          }
        }

        if (LiveEventType.redCard == eventType) {
          if (TeamType.home == teamType) {
            homeTeamRedCards++;
          } else if (TeamType.away == teamType) {
            awayTeamRedCards++;
          }
        }

        if (LiveEventType.offside == eventType) {
          if (TeamType.home == teamType) {
            homeTeamOffsides++;
          } else if (TeamType.away == teamType) {
            awayTeamOffsides++;
          }
        }

        if (LiveEventType.offside == eventType) {
          if (TeamType.home == teamType) {
            homeTeamOffsides++;
          } else if (TeamType.away == teamType) {
            awayTeamOffsides++;
          }
        }

        if (LiveEventType.throwIn == eventType) {
          if (TeamType.home == teamType) {
            homeTeamThrowIns++;
          } else if (TeamType.away == teamType) {
            awayTeamThrowIns++;
          }
        }
      });
    }
    final TeamUiModel homeTeamUiModel = TeamUiModel();
    final TeamUiModel awayTeamUiModel = TeamUiModel();
    homeTeamUiModel.goals = homeTeamGoals;
    awayTeamUiModel.goals = awayTeamGoals;
    homeTeamUiModel.cornerKicks = homeTeamCornerKicks;
    awayTeamUiModel.cornerKicks = awayTeamCornerKicks;
    homeTeamUiModel.yellowCards = homeTeamYellowCards;
    awayTeamUiModel.yellowCards = awayTeamYellowCards;
    homeTeamUiModel.redCards = homeTeamRedCards;
    awayTeamUiModel.redCards = awayTeamRedCards;
    homeTeamUiModel.offSides = homeTeamOffsides;
    awayTeamUiModel.offSides = awayTeamOffsides;
    homeTeamUiModel.throwIns = homeTeamThrowIns;
    awayTeamUiModel.throwIns = awayTeamThrowIns;
    homeTeamUiModel.color = 'ffffff';
    awayTeamUiModel.color = 'ff0000';

    List<Competitor> competitors = timelineResponse.sportEvent.competitors;
    if (competitors != null && competitors.isNotEmpty) {
      competitors.forEach((competitor) {
        if (competitor.getTeamType() == TeamType.home) {
          homeTeamUiModel.id = competitor.id;
          homeTeamUiModel.name = competitor.name;
          homeTeamUiModel.country = competitor.country;
          homeTeamUiModel.type = TeamType.home;
        } else if (competitor.getTeamType() == TeamType.away) {
          awayTeamUiModel.id = competitor.id;
          awayTeamUiModel.name = competitor.name;
          awayTeamUiModel.country = competitor.country;
          awayTeamUiModel.type = TeamType.away;
        }
      });
    }

    return LiveWidgetUiModel(eventUiModels, homeTeamUiModel, awayTeamUiModel);
  }
}
