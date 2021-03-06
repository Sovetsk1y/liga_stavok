import 'package:equatable/equatable.dart';

abstract class SportWidgetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadIndividualTotal extends SportWidgetEvent {
  @override
  String toString() => 'Load individual total event';
}

class UpdateLiveData extends SportWidgetEvent {
  @override
  String toString() => 'Update live data event';
}
