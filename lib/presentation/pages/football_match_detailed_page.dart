import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liga/data/repository/live_data_repository.dart';
import 'package:liga/data/repository/static_data_repository.dart';
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
  ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  ExpandableController _matchCommentaryController = ExpandableController();
  ExpandableController _matchStatisticsController = ExpandableController();

  List<String> _funFacts = [];

  @override
  void initState() {
    super.initState();

    _initListeners();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => SportWidgetBloc(
          StaticDataRepository(_createNetworkClient(), _createConfig()),
          LiveDataRepository(_createNetworkClient(), _createConfig()),
          _createLog())
        ..add(LoadIndividualTotal()),
      child: BlocBuilder<SportWidgetBloc, SportWidgetState>(
          builder: (context, state) {
        if (state is SuccessLoadFunFacts) {
          _funFacts = state.funFacts;
        }
        return Scaffold(
          backgroundColor: AppColors.green,
          body: _buildBody(state),
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

  Widget _buildBody(SportWidgetState state) {
    return SafeArea(
      top: true,
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Container(
            color: AppColors.grey,
            padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLiveTag(),
                Visibility(
                  visible: _funFacts.isNotEmpty,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildPageViewIndicatorDot(
                          isActive:
                              _currentPage == _Constants.PAGE_VIEW_STATISTICS),
                      Visibility(
                        visible: _funFacts.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: _buildPageViewIndicatorDot(
                              isActive:
                                  _currentPage == _Constants.PAGE_VIEW_NEWS),
                        ),
                      )
                    ],
                  ),
                ),
                _buildExitButton()
              ],
            ),
          ),
          Container(
            color: AppColors.grey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 16, top: 8, left: 16, right: 16),
                  child: MatchCommentaryWidget(
                    controller: _matchCommentaryController,
                  ),
                ),
                SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: _funFacts.isEmpty
                      ? NeverScrollableScrollPhysics()
                      : PageScrollPhysics(parent: ClampingScrollPhysics()),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: MatchStatisticsWidget(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            controller: _matchStatisticsController,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _funFacts.isNotEmpty,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: MatchNewsWidget(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                funFacts: _funFacts),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 300,
            color: Colors.white,
            child: Center(
              child: Text('Куча различных котировок',
                  style: Theme.of(context).textTheme.headline2),
            ),
          )
        ],
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

  void _initListeners() {
    _scrollController.addListener(() {
      if (_scrollController.offset >
          _scrollController.position.maxScrollExtent /
              2) if (_currentPage != 1) {
        if (_matchStatisticsController.expanded)
          _matchStatisticsController.toggle();
        setState(() {
          _currentPage = 1;
        });
      }
      if (_scrollController.offset <
          _scrollController.position.maxScrollExtent / 2) if (_currentPage != 0)
        setState(() {
          _currentPage = 0;
        });
    });

    _matchCommentaryController.addListener(() {
      if (_matchCommentaryController.expanded &&
          _matchStatisticsController.expanded)
        _matchStatisticsController.toggle();
    });

    _matchStatisticsController.addListener(() {
      if (_matchStatisticsController.expanded &&
          _matchCommentaryController.expanded)
        _matchCommentaryController.toggle();
    });
  }

  NetworkClient _createNetworkClient() {
    final dio = Dio();
    return NetworkClient(dio);
  }

  Config _createConfig() => Config();

  Log _createLog() => Log();
}
