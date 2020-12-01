import 'package:equatable/equatable.dart';
import 'package:liga/data/model/live_widget_ui_model.dart';
import 'package:liga/data/model/results.dart';
import 'package:liga/data/model/team_ui_model.dart';

abstract class SportWidgetState extends Equatable {
  const SportWidgetState();

  @override
  List<Object> get props => [];
}

class Initial extends SportWidgetState {
  @override
  String toString() => 'Initial sport widget state';
}

class Success extends SportWidgetState {
  @override
  String toString() => 'Success sport widget state';
}

class SuccessLoadFunFacts extends SportWidgetState {
  final List<String> funFacts;

  SuccessLoadFunFacts(this.funFacts);
}

class SuccessUpdateLiveData extends SportWidgetState {
  final LiveWidgetUiModel uiModel;

  SuccessUpdateLiveData(this.uiModel);

  @override
  String toString() => 'Success update live data state';

  @override
  List<Object> get props => [uiModel];
}

class SuccessUpdateTeamMatchStatistics extends SportWidgetState {
  final TeamType teamType;
  final List<MatchResult> results;

  SuccessUpdateTeamMatchStatistics(this.teamType, this.results);

  @override
  String toString() => 'Success update team matches statistics';

  @override
  List<Object> get props => [teamType, results];
}

class NetworkNotAvailable extends SportWidgetState {
  @override
  String toString() => 'Network not available state';
}

class Failure extends SportWidgetState {
  @override
  String toString() => 'Failure sport widget state';
}

enum Type { serverNotAvailable, noInternetConnection, unknown }
