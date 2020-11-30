import 'package:flutter/material.dart';
import 'package:liga/utils/app_colors.dart';
import 'package:liga/utils/constants.dart';

class _Constants {
  static const WIDGET_TITLE = 'НОВОСТИ/ИНСАЙТЫ';
  static const double NEWS_LIST_VIEW_HEIGHT = 183;
  static const NEWS_TEST_TEXT =
      'Помогать главному судье на бровках будут Октавиан Шовре и Себастьян Георге. Обязанности четвертого арбитра достались Себастьяну Колцеску.';
}

class MatchNewsWidget extends StatefulWidget {
  final EdgeInsetsGeometry padding;

  MatchNewsWidget({this.padding});

  @override
  _MatchNewsWidgetState createState() => _MatchNewsWidgetState();
}

class _MatchNewsWidgetState extends State<MatchNewsWidget> {
  @override
  Widget build(BuildContext context) => Container(
        margin: widget.padding,
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
                itemCount: 1,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNews(DateTime.now(), _Constants.NEWS_TEST_TEXT),
                    SizedBox(height: 8)
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget _buildNews(DateTime date, String text) {
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
                  '24 ноября 2020',
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
