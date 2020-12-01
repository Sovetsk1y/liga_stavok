import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liga/presentation/widgets/match_statistics/single_statistics_indicator.dart';
import 'package:liga/utils/app_colors.dart';

class StatisticsWidgetOnboarding extends StatelessWidget {
  final bool visible;
  final VoidCallback onShouldClose;

  StatisticsWidgetOnboarding(
      {@required this.visible, @required this.onShouldClose});

  @override
  Widget build(BuildContext context) => Visibility(
        visible: visible,
        child: GestureDetector(
          onTap: onShouldClose,
          onLongPress: onShouldClose,
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                color: Colors.black54,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(100)),
                      child: SingleStatisticsIndicator(
                        title: 'Угловые',
                        homeValue: 12,
                        awayValue: 7,
                        progressBackgroundColor: AppColors.lightGrey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40, top: 16),
                      child: Text(
                          'Зажмите и удерживайте, чтобы переместить строку в избранное',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),
                    _buildConfirmOnboardingButton()
                  ],
                ),
              )),
        ),
      );

  Center _buildConfirmOnboardingButton() => Center(
          child: GestureDetector(
        onTap: onShouldClose,
        child: Container(
          margin: EdgeInsets.only(bottom: 48),
          height: 35,
          width: 146,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(100)),
          child: Center(
            child: Text('Понятно',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ),
      ));
}
