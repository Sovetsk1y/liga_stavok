import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liga/data/repository/team_repository.dart';
import 'package:liga/feature/widget/sport_widget_bloc.dart';
import 'package:liga/feature/widget/sport_widget_event.dart';
import 'package:liga/feature/widget/sport_widget_state.dart';
import 'package:liga/net/network_client.dart';
import 'package:liga/presentation/widgets/match_commentary/match_commentary_widget.dart';
import 'package:liga/presentation/widgets/match_news/match_news_widget.dart';
import 'package:liga/presentation/widgets/match_statistics/match_statistics_widget.dart';
import 'package:liga/utils/app_colors.dart';
import 'package:liga/utils/app_icons.dart';
import 'package:liga/utils/log.dart';

import '../../config.dart';

class _Constants {
  //dimensions
  static const double PAGE_VIEW_INDICATOR_DOT_SIDE = 6;

  //page view indexes
  static const int PAGE_VIEW_STATISTICS = 0;
  static const int PAGE_VIEW_NEWS = 1;
}

class FootballMatchDetailedPage extends StatefulWidget {
  @override
  _FootballMatchDetailedPageState createState() =>
      _FootballMatchDetailedPageState();
}

class _FootballMatchDetailedPageState extends State<FootballMatchDetailedPage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => SportWidgetBloc(
          TeamRepository(_createNetworkClient(), Config()), Log())
        ..add(LoadIndividualTotal()),
      child: BlocBuilder<SportWidgetBloc, SportWidgetState>(
          builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.green,
          body: _buildBody(),
        );
      }));

  Container _buildExitButton() {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
      child: AppIcons.exit,
    );
  }

  Row _buildLiveTag() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: AppColors.red),
        ),
        SizedBox(width: 4),
        Text('live', style: Theme.of(context).textTheme.headline3)
      ],
    );
  }

  Widget _buildBody() {
    return SafeArea(
      top: true,
      child: Container(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: AppColors.grey,
                padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLiveTag(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildPageViewIndicatorDot(
                            isActive: _currentPage ==
                                _Constants.PAGE_VIEW_STATISTICS),
                        SizedBox(width: 6),
                        _buildPageViewIndicatorDot(
                            isActive: _currentPage == _Constants.PAGE_VIEW_NEWS)
                      ],
                    ),
                    _buildExitButton()
                  ],
                ),
              ),
              Container(
                color: AppColors.grey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 16, top: 8, left: 16, right: 16),
                      child: MatchCommentaryWidget(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AspectRatio(
                        aspectRatio: 3 / 2,
                        child: PageView(
                            pageSnapping: true,
                            onPageChanged: (page) {
                              setState(() {
                                _currentPage = page;
                              });
                            },
                            children: [
                              MatchStatisticsWidget(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                              MatchNewsWidget(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 500,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildPageViewIndicatorDot({bool isActive = false}) {
    return Container(
      width: _Constants.PAGE_VIEW_INDICATOR_DOT_SIDE,
      height: _Constants.PAGE_VIEW_INDICATOR_DOT_SIDE,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? Colors.white : AppColors.lightGrey),
    );
  }

  NetworkClient _createNetworkClient() {
    final dio = Dio();
    return NetworkClient(dio);
  }
}
