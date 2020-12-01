import 'package:liga/data/model/live_event_ui_model.dart';
import 'package:liga/data/model/team_ui_model.dart';

class LiveWidgetUiModel {
  bool live;
  List<LiveEventUiModel> liveEventUiModels;
  TeamUiModel homeTeamUiModel;
  TeamUiModel awayTeamUiModel;
  List<Exception> exceptions;

  bool hasErrors() => exceptions != null && exceptions.isNotEmpty;
}
