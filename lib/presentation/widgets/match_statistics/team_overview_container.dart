import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liga/data/model/results.dart';
import 'package:liga/utils/constants.dart';

import 'match_result_thumbnail.dart';

class TeamOverviewContainer extends StatelessWidget {
  final Color teamColor;
  final List<MatchResult> results;
  final String teamName;

  TeamOverviewContainer(
      {@required this.teamColor,
      @required this.results,
      @required this.teamName});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(Constants.TEAM_EMPTY_LOGO, color: teamColor),
          SizedBox(height: 8),
          Text(teamName, style: Theme.of(context).textTheme.headline3),
          SizedBox(height: 4),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(results.length,
                  (index) => MatchResultThumbnail(results[index])))
        ],
      );
}
