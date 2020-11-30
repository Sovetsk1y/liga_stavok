import 'package:flutter/material.dart';
import 'package:liga/data/model/team_results.dart';
import 'package:liga/utils/app_colors.dart';

class _Constants {
  static const double kMatchResultSignFontSize = 12;
  static final BorderRadius kMatchResultsContainerBorderRadius =
      BorderRadius.circular(3);
}

class MatchResultThumbnail extends StatelessWidget {
  final MatchResult result;

  MatchResultThumbnail(this.result);

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: _Constants.kMatchResultsContainerBorderRadius),
        child: Center(child: _matchResultSign(result)),
      );

  Text _matchResultSign(MatchResult result) {
    switch (result) {
      case MatchResult.win:
        return Text('В',
            style: TextStyle(
                color: AppColors.green,
                fontSize: _Constants.kMatchResultSignFontSize,
                fontWeight: FontWeight.w600));
      case MatchResult.lose:
        return Text('П',
            style: TextStyle(
                color: AppColors.red,
                fontSize: _Constants.kMatchResultSignFontSize,
                fontWeight: FontWeight.w600));
      case MatchResult.draw:
        return Text('Н',
            style: TextStyle(
                color: AppColors.orange,
                fontSize: _Constants.kMatchResultSignFontSize,
                fontWeight: FontWeight.w600));
      default:
        return Text('');
    }
  }
}
