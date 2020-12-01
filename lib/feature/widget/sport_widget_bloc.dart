import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:liga/data/model/live_widget_ui_model.dart';
import 'package:liga/data/model/results.dart';
import 'package:liga/data/model/team_ui_model.dart';
import 'package:liga/data/repository/live_data_repository.dart';
import 'package:liga/data/repository/static_data_repository.dart';
import 'package:liga/feature/widget/sport_widget_event.dart';
import 'package:liga/feature/widget/sport_widget_state.dart';
import 'package:liga/net/exceptions.dart';
import 'package:liga/utils/log.dart';

class SportWidgetBloc extends Bloc<SportWidgetEvent, SportWidgetState> {
  static const int _LIVE_DATA_UPDATE_DURATION_IN_SECONDS = 30;

  final StaticDataRepository _staticDataRepository;
  final LiveDataRepository _liveDataRepository;
  final Log _log;

  final Duration _duration =
      Duration(seconds: _LIVE_DATA_UPDATE_DURATION_IN_SECONDS);

  Map<String, List<MatchResult>> teamsMatchResults = HashMap();

  SportWidgetBloc(
      this._staticDataRepository, this._liveDataRepository, this._log)
      : super(Initial()) {
    Timer(_duration, _handleTimeout);
  }

  @override
  Stream<SportWidgetState> mapEventToState(SportWidgetEvent event) async* {
    _log.d('Receive sport widget event - $event');
    if (event is LoadIndividualTotal) {
      try {
        int individualTotal = await _staticDataRepository
            .getIndividualTotalForLastMatches('sr:competitor:23992');
        _log.d('load individual total $individualTotal');

        List<String> funFacts = await _staticDataRepository.getMatchFunFacts(
            'sr:match:19173938', 3);
        _log.d('Load match fun facts $funFacts');
        yield SuccessLoadFunFacts(funFacts);
      } catch (exception) {
        _log.e('Can\'t load data', exception);
        yield Failure();
      }
    } else if (event is UpdateLiveData) {
      try {
        LiveWidgetUiModel uiModel =
            await _liveDataRepository.getMatchData('sr:match:23390741');
        if (uiModel.hasErrors()) {
          if (uiModel.exceptions.first is NetworkNotAvailableException) {
            yield NetworkNotAvailable();
          } else {
            yield Failure();
          }
        } else {
          String homeTeamId = uiModel.homeTeamUiModel.id;
          String awayTeamId = uiModel.awayTeamUiModel.id;
          yield SuccessUpdateLiveData(uiModel);

          if (homeTeamId != null &&
              homeTeamId.isNotEmpty &&
              teamsMatchResults[homeTeamId] == null) {
            List<MatchResult> matchesResults =
                await _staticDataRepository.getLastMatchesResults(homeTeamId);
            _log.d('Load last matches results for home team $matchesResults');
            teamsMatchResults.putIfAbsent(homeTeamId, () => matchesResults);
            yield SuccessUpdateTeamMatchStatistics(
                TeamType.home, matchesResults);
          }

          if (awayTeamId != null &&
              awayTeamId.isNotEmpty &&
              teamsMatchResults[awayTeamId] == null) {
            List<MatchResult> matchesResults =
                await _staticDataRepository.getLastMatchesResults(awayTeamId);
            _log.d('Load last matches results for away team $matchesResults');
            teamsMatchResults.putIfAbsent(awayTeamId, () => matchesResults);
            yield SuccessUpdateTeamMatchStatistics(
                TeamType.away, matchesResults);
          }
        }
      } catch (exception) {
        _log.e('Can\'t load data', exception);
        yield Failure();
      }
    }
  }

  void _handleTimeout() {
    add(UpdateLiveData());
    Timer(_duration, _handleTimeout);
  }
}
