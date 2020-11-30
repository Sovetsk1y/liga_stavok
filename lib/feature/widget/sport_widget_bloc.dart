import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:liga/data/model/live_event.dart';
import 'package:liga/data/model/team_results.dart';
import 'package:liga/data/repository/live_data_repository.dart';
import 'package:liga/data/repository/static_data_repository.dart';
import 'package:liga/feature/widget/sport_widget_event.dart';
import 'package:liga/feature/widget/sport_widget_state.dart';
import 'package:liga/utils/log.dart';

class SportWidgetBloc extends Bloc<SportWidgetEvent, SportWidgetState> {
  static const int _LIVE_DATA_UPDATE_DURATION_IN_SECONDS = 30;

  final StaticDataRepository _staticDataRepository;
  final LiveDataRepository _liveDataRepository;
  final Log _log;

  final Duration _duration = Duration(seconds: _LIVE_DATA_UPDATE_DURATION_IN_SECONDS);

  SportWidgetBloc(this._staticDataRepository, this._liveDataRepository, this._log) : super(Initial()) {
    Timer(_duration, _handleTimeout);
  }

  @override
  Stream<SportWidgetState> mapEventToState(SportWidgetEvent event) async* {
    _log.d('Receive sport widget event - $event');
    if (event is LoadIndividualTotal) {
      yield Loading();

      try {
        int individualTotal = await _staticDataRepository.getIndividualTotalForLastMatches('23992');
        _log.d('load individual total $individualTotal');

        List<MatchResult> matchesResults = await _staticDataRepository.getLastMatchesResults('23992');
        _log.d('Load last matches results $matchesResults');

        List<String> funFacts = await _staticDataRepository.getMatchFunFacts('sr:match:19173938', 3);
        _log.d('Load match fun facts $funFacts');
      } catch (exception) {
        _log.e('Can\'t load data', exception);
      }
    } else if (event is UpdateLiveData) {
      try {
        LiveEvent event = await _liveDataRepository.getLiveEvent();
        List<LiveEvent> events = await _liveDataRepository.getLiveEvents();

        yield SuccessUpdateLiveData(event, events);
      } catch (exception) {
        _log.e('Can\'t load live events', exception);
      }
    }
  }

  void _handleTimeout() {
    add(UpdateLiveData());
    Timer(_duration, _handleTimeout);
  }
}
