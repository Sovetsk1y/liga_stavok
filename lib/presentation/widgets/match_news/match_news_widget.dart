import 'package:flutter/material.dart';
import 'package:liga/utils/app_colors.dart';
import 'package:liga/utils/constants.dart';

class _Constants {
  static const WIDGET_TITLE = 'НОВОСТИ/ИНСАЙТЫ';
  static const double NEWS_LIST_VIEW_HEIGHT = 183;
}

class MatchNewsWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final List<String> funFacts;

  MatchNewsWidget({this.padding, this.funFacts = const []});

  @override
  Widget build(BuildContext context) => Container(
        margin: padding,
        padding: EdgeInsets.only(top: 16, bottom: 16),
        decoration: BoxDecoration(
            borderRadius: Constants.kBorderRadius, color: Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(_Constants.WIDGET_TITLE,
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: _Constants.NEWS_LIST_VIEW_HEIGHT,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: funFacts.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildFunFact(context, funFacts[index]),
                        SizedBox(height: 8)
                      ],
                    );
                  }),
            )
          ],
        ),
      );

  Widget _buildFunFact(BuildContext context, String fact) => IntrinsicHeight(
        child: Row(
          children: [
            Container(
                width: 7,
                decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)))),
            SizedBox(width: 8),
            Expanded(
              child: Text(fact, style: Theme.of(context).textTheme.headline4),
            ),
            SizedBox(width: 8)
          ],
        ),
      );

  Widget _buildNews(BuildContext context, DateTime date, String text) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
              width: 7,
              decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)))),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date.toString(),
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(text, style: Theme.of(context).textTheme.headline4),
              ],
            ),
          ),
          SizedBox(width: 8)
        ],
      ),
    );
  }
}
