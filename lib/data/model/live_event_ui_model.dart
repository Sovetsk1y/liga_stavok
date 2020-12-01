import 'package:liga/data/model/match_timeline.dart';

import '../enum.dart';

class LiveEventUiModel {
  final int id;
  final LiveEventType type;
  final String time;
  GoalScorer goalScorer;
  Player player;

  LiveEventUiModel(this.id, this.type, this.time, {this.goalScorer, this.player});
}

class LiveEventType extends Enum<String> {
  const LiveEventType(String value) : super(value);

  static const matchStarted = const LiveEventType('Матч начался');
  static const matchEnded = const LiveEventType('Матч закончился');
  static const periodStart = const LiveEventType('Период начался');
  static const breakStart = const LiveEventType('Перерыв начался');
  static const throwIn = const LiveEventType('throwIn');
  static const freeKick = const LiveEventType('freeKick');
  static const goalKick = const LiveEventType('Удар от ворот');
  static const cornerKick = const LiveEventType('Угловой');
  static const scoreChange = const LiveEventType('Гол');
  static const yellowCard = const LiveEventType('Желтая карточка');
  static const redCard = const LiveEventType('Красная карточка');
  static const shotOffTarget = const LiveEventType('shotOffTarget');
  static const shotOnTarget = const LiveEventType('shotOnTarget');
  static const shotSaved = const LiveEventType('shotSaved');
  static const offside = const LiveEventType('offside');
  static const injury = const LiveEventType('injury');
  static const injuryReturn = const LiveEventType('injuryReturn');
  static const injuryTimeShown = const LiveEventType('injuryTimeShown');
  static const unknown = const LiveEventType('');
}
