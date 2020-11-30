import 'package:flutter/material.dart';
import 'package:liga/utils/app_colors.dart';
import 'package:liga/utils/constants.dart';

class _Constants {
  static const WIDGET_TITLE = 'НОВОСТИ/ИНСАЙТЫ';
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
        padding: EdgeInsets.only(top: 16),
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
            _buildNews(DateTime.now(), _Constants.NEWS_TEST_TEXT)
          ],
        ),
      );

  Widget _buildNews(DateTime date, String text) {
    return Row(
      children: [
        Container(
          width: 7,
          color: AppColors.lightGrey,
          child: Column(),
        ),
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
    );
  }
}
