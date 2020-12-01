import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:liga/data/model/live_event_ui_model.dart';

// ignore: unused_import
import 'package:liga/data/model/live_results.dart';
import 'package:liga/data/model/live_widget_ui_model.dart';
import 'package:liga/data/model/match_timeline.dart';
import 'package:liga/data/model/team_ui_model.dart';
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
    List<LiveEventUiModel> liveEventModels = _mapToLiveEventUiModels(timelineItems);
    final TeamUiModel homeTeamUiModel = TeamUiModel('id', 'name', 'country', TeamType.home, 0, 0, 0, 0, 0, 'ffffff');
    final TeamUiModel awayTeamUiModel = TeamUiModel('id', 'name', 'country', TeamType.away, 0, 0, 0, 0, 0, 'ff0000');
    return LiveWidgetUiModel(liveEventModels, homeTeamUiModel, awayTeamUiModel);
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

  List<LiveEventUiModel> _mapToLiveEventUiModels(List<TimelineItem> timelineItems) {
    List<LiveEventUiModel> eventUiModels = List<LiveEventUiModel>();
    if (timelineItems != null && timelineItems.isNotEmpty) {
      List<TimelineItem> reversedItems = List.from(timelineItems.reversed);
      reversedItems.forEach((timelineItem) {
        final model = LiveEventUiModel(
            timelineItem.id, timelineItem.getLiveEventType(), timelineItem.matchTime.toString(), timelineItem.getTeamType(),
            goalScorer: timelineItem.goalScorer, player: timelineItem.player);
        eventUiModels.add(model);
      });
    }
    return eventUiModels;
  }
}
