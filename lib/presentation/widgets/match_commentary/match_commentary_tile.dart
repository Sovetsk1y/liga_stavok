import 'package:flutter/material.dart';
import 'package:liga/data/model/live_event_ui_model.dart';
import 'package:liga/data/model/team_ui_model.dart';
import 'package:liga/utils/app_colors.dart';

class _Constants {
  static const double TEAM_INDICATOR_HEIGHT = 40;

  static const String GOAL_IMAGE = 'assets/images/goal.png';
  static const String YELLOW_CARD_IMAGE = 'assets/images/yellow_card.png';
  static const String RED_CARD_IMAGE = 'assets/images/red_card.png';
  static const String CORNER_IMAGE = 'assets/images/corner.png';
}

class MatchCommentaryTile extends StatelessWidget {
  final LiveEventUiModel liveEvent;

  MatchCommentaryTile(this.liveEvent);

  @override
  Widget build(BuildContext context) => Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            Row(
              children: [
                _buildMatchCommentaryTeamIndicator(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                      '${liveEvent.time == 'null' ? 0 : liveEvent.time}‘',
                      style: Theme.of(context).textTheme.headline2),
                ),
                _eventIcon(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(liveEvent.type.value,
                      style: Theme.of(context).textTheme.headline3),
                ),
                Visibility(
                  visible: liveEvent.type == LiveEventType.scoreChange,
                  child: Container(
                    height: 16,
                    width: 1,
                    decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      liveEvent.type == LiveEventType.scoreChange
                          ? liveEvent.goalScorer.name
                          : liveEvent.player?.name?.toString() ?? '',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _eventIcon() {
    String iconPath;
    switch (liveEvent.type) {
      case LiveEventType.scoreChange:
        iconPath = _Constants.GOAL_IMAGE;
        break;
      case LiveEventType.yellowCard:
        iconPath = _Constants.YELLOW_CARD_IMAGE;
        break;
      case LiveEventType.redCard:
        iconPath = _Constants.RED_CARD_IMAGE;
        break;
      case LiveEventType.cornerKick:
        iconPath = _Constants.CORNER_IMAGE;
    }
    return iconPath == null
        ? Container()
        : Image.asset(iconPath, width: 24, height: 24);
  }

  Container _buildMatchCommentaryTeamIndicator() => Container(
        height: _Constants.TEAM_INDICATOR_HEIGHT,
        width: 7,
        decoration: BoxDecoration(
            color: _getTeamColor(),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      );

  // ignore: missing_return
  Color _getTeamColor() {
    switch (liveEvent.teamType) {
      case TeamType.home:
        return AppColors.green;
      case TeamType.away:
        return Colors.white;
      case TeamType.unknown:
        return AppColors.lightGrey;
    }
  }
}
