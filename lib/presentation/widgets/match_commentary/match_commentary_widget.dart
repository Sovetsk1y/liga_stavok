import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:liga/utils/app_colors.dart';
import 'package:liga/utils/app_icons.dart';
import 'package:liga/utils/constants.dart';

class _Constants {
  //dimensions
  static const double TEAM_INDICATOR_HEIGHT = 40;

  //assets
  static const String GOAL_IMAGE = 'assets/images/goal.png';
}

class MatchCommentaryWidget extends StatefulWidget {
  final ExpandableController controller;

  MatchCommentaryWidget({this.controller});

  @override
  _MatchCommentaryTileState createState() => _MatchCommentaryTileState();
}

class _MatchCommentaryTileState extends State<MatchCommentaryWidget> {
  @override
  Widget build(BuildContext context) => ExpandableNotifier(
        controller: widget.controller,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: Constants.kBorderRadius),
          child: Column(
            children: [
              Expandable(
                collapsed: _buildMatchCommentaryTile(isFirst: true),
                expanded: Column(
                  children: List.generate(
                      5,
                      (index) => index == 4
                          ? _buildMatchCommentaryTile(isLast: true)
                          : _buildMatchCommentaryTile()),
                ),
              )
            ],
          ),
        ),
      );

  Container _buildMatchCommentaryTile(
      {bool isFirst = false, bool isLast = false}) {
    return Container(
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
                child:
                    Text('35‘', style: Theme.of(context).textTheme.headline2),
              ),
              Image.asset(_Constants.GOAL_IMAGE, width: 24, height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child:
                    Text('Гол', style: Theme.of(context).textTheme.headline3),
              ),
              Container(
                height: 16,
                width: 1,
                decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(4)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Карим Бензема',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
              Visibility(
                visible: isFirst,
                child: ExpandableButton(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AppIcons.arrowDown,
                  ),
                ),
              ),
              Visibility(
                visible: isLast,
                child: ExpandableButton(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AppIcons.arrowUp,
                  ),
                ),
              )
            ],
          ),
          Visibility(visible: !isFirst && !isLast, child: SizedBox(height: 8))
        ],
      ),
    );
  }

  Container _buildMatchCommentaryTeamIndicator() => Container(
        height: _Constants.TEAM_INDICATOR_HEIGHT,
        width: 7,
        decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      );
}
