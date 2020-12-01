import 'package:equatable/equatable.dart';
import 'package:liga/data/model/live_event.dart';

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

class SuccessLoadFunFacts extends SportWidgetState {
  final List<String> funFacts;

  SuccessLoadFunFacts(this.funFacts);
}

class SuccessUpdateLiveData extends SportWidgetState {
  final LiveEvent event;
  final List<LiveEvent> events;

  SuccessUpdateLiveData(this.event, this.events);

  @override
  String toString() => 'Success update live data state';

  @override
  List<Object> get props => [event, events];
}

class Failure extends SportWidgetState {
  @override
  String toString() => 'Failure sport widget state';
}

enum Type { serverNotAvailable, noInternetConnection, unknown }
