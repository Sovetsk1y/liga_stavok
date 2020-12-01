import 'package:liga/data/model/match_timeline.dart';
import 'package:liga/data/model/team_ui_model.dart';

import '../enum.dart';

class LiveEventUiModel {
  final int id;
  final LiveEventType type;
  final String time;
  final TeamType teamType;
  GoalScorer goalScorer;
  Player player;

  LiveEventUiModel(this.id, this.type, this.time, this.teamType,
      {this.goalScorer, this.player});
}

class LiveEventType extends Enum<String> {
  const LiveEventType(String value) : super(value);

  static const matchStarted = const LiveEventType('Матч начался');
  static const matchEnded = const LiveEventType('Матч закончился');
  static const periodStart = const LiveEventType('Тайм начался');
  static const breakStart = const LiveEventType('Перерыв начался');
  static const throwIn = const LiveEventType('Аут');
  static const freeKick = const LiveEventType('Штрафной удар');
  static const goalKick = const LiveEventType('Удар от ворот');
  static const cornerKick = const LiveEventType('Угловой');
  static const scoreChange = const LiveEventType('Гол');
  static const yellowCard = const LiveEventType('Желтая карточка');
  static const redCard = const LiveEventType('Красная карточка');
  static const shotOffTarget = const LiveEventType('Удар мимо');
  static const shotOnTarget = const LiveEventType('Удар в створ');
  static const shotSaved = const LiveEventType('Сейв');
  static const offside = const LiveEventType('Офсайд');
  static const injury = const LiveEventType('Травма');
  static const injuryReturn =
      const LiveEventType('Возврат травмированного игрока');
  static const substitution = const LiveEventType('Замена');
  static const penaltyAwarded = const LiveEventType('Назначен пенальти');
  static const videoAssistantReferee = const LiveEventType('VAR');
  static const videoAssistantRefereeOver = const LiveEventType('VAR');
  static const unknown = const LiveEventType('');
}
