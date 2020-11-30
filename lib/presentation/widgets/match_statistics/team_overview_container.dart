import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liga/data/model/team_results.dart';
import 'package:liga/utils/constants.dart';

import 'match_result_thumbnail.dart';

class TeamOverviewContainer extends StatelessWidget {
  final Color teamColor;

  TeamOverviewContainer({@required this.teamColor});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(Constants.TEAM_EMPTY_LOGO, color: teamColor),
          SizedBox(height: 8),
          Text('FC Shakhtar', style: Theme.of(context).textTheme.headline3),
          SizedBox(height: 4),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  5, (index) => MatchResultThumbnail(MatchResult.win)))
        ],
      );
}
