import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liga/data/model/results.dart';
import 'package:liga/data/model/team_ui_model.dart';
import 'package:liga/feature/widget/sport_widget_bloc.dart';
import 'package:liga/feature/widget/sport_widget_state.dart';
import 'package:liga/presentation/widgets/match_statistics/single_statistics_indicator.dart';
import 'package:liga/presentation/widgets/match_statistics/team_overview_container.dart';
import 'package:liga/utils/app_icons.dart';
import 'package:liga/utils/constants.dart';

class _Constants {
  static const STATISTIC_INDICATORS_COLLAPSED_LENGTH = 3;
}

class MatchStatisticsWidget extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final ExpandableController controller;
  final VoidCallback onShowOnboarding;

  MatchStatisticsWidget(
      {Key key, this.padding, this.controller, this.onShowOnboarding})
      : super(key: key);

  @override
  _MatchStatisticsWidgetState createState() => _MatchStatisticsWidgetState();
}

class _MatchStatisticsWidgetState extends State<MatchStatisticsWidget> {
  bool _isFirstExpansion = true;

  ExpandableController _expandableController;

  List _children;
  List<MatchResult> _homeResults = [];
  List<MatchResult> _awayResults = [];

  @override
  void initState() {
    super.initState();

    _expandableController = widget.controller ?? ExpandableController();
    _children = List.generate(
        10,
        (index) => SingleStatisticsIndicator(
            homeValue: 12, awayValue: 7, title: 'Угловые'));
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SportWidgetBloc, SportWidgetState>(builder: (context, state) {
        if (state is SuccessUpdateTeamMatchStatistics) {
          if (state.teamType == TeamType.home)
            _homeResults = state.results;
          else
            _awayResults = state.results;
        }
        if (state is Failure)
          return Container(
            margin: widget.padding,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: Constants.kBorderRadius),
            child: Center(
                child: Text(
                    'Отсутствует интернет-соединение. Попробуйте позже.',
                    style: Theme.of(context).textTheme.headline2)),
          );
        if (state is NetworkNotAvailable) {
          return Container(
            margin: widget.padding,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: Constants.kBorderRadius),
            child: Center(
                child: Text(
                    'Отсутствует интернет-соединение. Попробуйте позже.',
                    style: Theme.of(context).textTheme.headline3)),
          );
        }
        return ExpandableNotifier(
          controller: _expandableController,
          child: Container(
            margin: widget.padding,
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: Constants.kBorderRadius),
            child: Expandable(
              collapsed: _buildCollapsed(context),
              expanded: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCollapsed(context, isExpanded: true),
                  ExpandableButton(child: AppIcons.arrowUp)
                ],
              ),
            ),
          ),
        );
      });

  Column _buildCollapsed(BuildContext context, {bool isExpanded = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TeamOverviewContainer(
              teamColor: Colors.orange,
              results: _homeResults,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('3 : 1', style: Theme.of(context).textTheme.headline6),
                Text(
                  '41‘',
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            ),
            TeamOverviewContainer(
              teamColor: Colors.purple,
              results: _awayResults,
            )
          ],
        ),
        SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: isExpanded
              ? _children.length
              : _Constants.STATISTIC_INDICATORS_COLLAPSED_LENGTH,
          itemBuilder: (context, index) => Draggable(
            data: _children[index],
            feedback: _children[index],
            childWhenDragging: _children[index],
            child: _children[index],
          ),
        ),
        Visibility(
          visible: !isExpanded && _isFirstExpansion,
          child: GestureDetector(
            onTap: () {
              if (_isFirstExpansion && widget.onShowOnboarding != null) {
                _isFirstExpansion = false;
                _expandableController.toggle();
                widget.onShowOnboarding();
              }
            },
            child: AbsorbPointer(
                absorbing: true,
                child: ExpandableButton(child: AppIcons.arrowDown)),
          ),
        ),
        Visibility(
            visible: !isExpanded && !_isFirstExpansion,
            child: ExpandableButton(child: AppIcons.arrowDown))
      ],
    );
  }
}
