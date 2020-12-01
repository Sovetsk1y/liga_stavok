import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:liga/presentation/widgets/match_statistics/single_statistics_indicator.dart';
import 'package:liga/presentation/widgets/match_statistics/team_overview_container.dart';
import 'package:liga/utils/app_icons.dart';
import 'package:liga/utils/constants.dart';

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

  @override
  void initState() {
    super.initState();

    _expandableController = widget.controller ?? ExpandableController();
  }

  @override
  Widget build(BuildContext context) => ExpandableNotifier(
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
                Container(
                  height: 200,
                ),
                ExpandableButton(child: AppIcons.arrowUp)
              ],
            ),
          ),
        ),
      );

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
            )
          ],
        ),
        SizedBox(height: 12),
        SingleStatisticsIndicator(homeValue: 3, awayValue: 2, title: 'Угловые'),
        SizedBox(height: 8),
        SingleStatisticsIndicator(
            homeValue: 1, awayValue: 3, title: 'Желтые карточки'),
        SizedBox(height: 8),
        SingleStatisticsIndicator(
            homeValue: 0, awayValue: 11, title: 'Красные карточки'),
        SizedBox(height: 8),
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
