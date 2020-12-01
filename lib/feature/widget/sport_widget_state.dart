import 'package:equatable/equatable.dart';
import 'package:liga/data/model/live_event_ui_model.dart';
import 'package:liga/data/model/live_widget_ui_model.dart';

abstract class SportWidgetState extends Equatable {
  const SportWidgetState();

  @override
  List<Object> get props => [];
}

class Initial extends SportWidgetState {
  @override
  String toString() => 'Initial sport widget state';
}

class Loading extends SportWidgetState {
  @override
  String toString() => 'Loading sport widget state';
}

class Success extends SportWidgetState {
  @override
  String toString() => 'Success sport widget state';
}

class SuccessUpdateLiveData extends SportWidgetState {
  final LiveWidgetUiModel uiModel;

  SuccessUpdateLiveData(this.uiModel);

  @override
  String toString() => 'Success update live data state';

  @override
  List<Object> get props => [uiModel];
}

class Failure extends SportWidgetState {
  @override
  String toString() => 'Failure sport widget state';
}

enum Type { serverNotAvailable, noInternetConnection, unknown }
