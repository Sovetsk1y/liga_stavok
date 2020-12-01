import 'package:liga/data/model/live_event_ui_model.dart';
import 'package:liga/data/model/team_ui_model.dart';

class LiveWidgetUiModel {
  final bool live;
  final List<LiveEventUiModel> liveEventUiModels;
  final TeamUiModel homeTeamUiModel;
  final TeamUiModel awayTeamUiModel;

  LiveWidgetUiModel(this.live, this.liveEventUiModels, this.homeTeamUiModel, this.awayTeamUiModel);
}
