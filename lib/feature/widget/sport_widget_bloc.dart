import 'package:bloc/bloc.dart';
import 'package:liga/data/model/team_results.dart';
import 'package:liga/data/repository/team_repository.dart';
import 'package:liga/feature/widget/sport_widget_event.dart';
import 'package:liga/feature/widget/sport_widget_state.dart';
import 'package:liga/utils/log.dart';

class SportWidgetBloc extends Bloc<SportWidgetEvent, SportWidgetState> {
  final TeamRepository _repository;
  final Log _log;

  SportWidgetBloc(this._repository, this._log) : super(Initial());

  @override
  Stream<SportWidgetState> mapEventToState(SportWidgetEvent event) async* {
    _log.d('Receive sport widget event - $event');
    if (event is LoadIndividualTotal) {
      yield Loading();

      try {
        int individualTotal = await _repository.getIndividualTotalForLastMatches('23992');
        List<MatchResult> matchesResults = await _repository.getLastMatchesResults('23992');
        _log.d('load individual total $individualTotal');
        _log.d('Load last matches results $matchesResults');
      } catch (exception) {
        _log.e('Can\'t load individual total', exception);
      }
    }
  }
}
