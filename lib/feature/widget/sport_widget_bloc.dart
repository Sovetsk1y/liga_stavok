import 'package:bloc/bloc.dart';
import 'package:liga/data/model/team_results.dart';
import 'package:liga/data/repository/static_data_repository.dart';
import 'package:liga/feature/widget/sport_widget_event.dart';
import 'package:liga/feature/widget/sport_widget_state.dart';
import 'package:liga/utils/log.dart';

class SportWidgetBloc extends Bloc<SportWidgetEvent, SportWidgetState> {
  final StaticDataRepository _staticDataRepository;
  final Log _log;

  SportWidgetBloc(this._staticDataRepository, this._log) : super(Initial());

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
    }
  }
}
