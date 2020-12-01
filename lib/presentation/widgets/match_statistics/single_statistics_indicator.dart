import 'package:flutter/material.dart';
import 'package:liga/utils/app_colors.dart';
import 'package:liga/utils/constants.dart';

class _Constants {
  static const double kLinearProgressIndicatorHeight = 6;
}

class SingleStatisticsIndicator extends StatelessWidget {
  final double homeValue;
  final double awayValue;
  final String title;
  final Widget icon;
  final Color progressBackgroundColor;

  SingleStatisticsIndicator(
      {@required this.homeValue,
      @required this.awayValue,
      @required this.title,
      this.progressBackgroundColor,
      this.icon});

  double get maxValue => homeValue + awayValue;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStatisticsRow(context),
          SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    minHeight: _Constants.kLinearProgressIndicatorHeight,
                    valueColor: AlwaysStoppedAnimation(
                        progressBackgroundColor ?? AppColors.grey),
                    backgroundColor:
                        homeValue > awayValue ? AppColors.green : Colors.white,
                    value: 1 - (homeValue / maxValue),
                  ),
                ),
                Expanded(
                  child: LinearProgressIndicator(
                    minHeight: _Constants.kLinearProgressIndicatorHeight,
                    backgroundColor: progressBackgroundColor ?? AppColors.grey,
                    valueColor: AlwaysStoppedAnimation(
                        awayValue > homeValue ? AppColors.green : Colors.white),
                    value: awayValue / maxValue,
                  ),
                )
              ],
            ),
          )
        ],
      );

  Row _buildStatisticsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(homeValue.toString().replaceAll(Constants.kTrailingZerosCut, ''),
            style: Theme.of(context).textTheme.headline3),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ?? Container(),
            Text(title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1)
          ],
        ),
        Text(awayValue.toString().replaceAll(Constants.kTrailingZerosCut, ''),
            style: Theme.of(context).textTheme.headline3)
      ],
    );
  }
}
