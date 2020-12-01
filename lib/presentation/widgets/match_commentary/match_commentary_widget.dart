import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liga/feature/widget/sport_widget_bloc.dart';
import 'package:liga/feature/widget/sport_widget_state.dart';
import 'package:liga/presentation/widgets/match_commentary/match_commentary_tile.dart';
import 'package:liga/utils/app_icons.dart';
import 'package:liga/utils/constants.dart';

class _Constants {
  //dimensions
  static const double EXPANDED_HEIGHT = 240;
}

class MatchCommentaryWidget extends StatefulWidget {
  final ExpandableController controller;

  MatchCommentaryWidget({this.controller});

  @override
  _MatchCommentaryTileState createState() => _MatchCommentaryTileState();
}

class _MatchCommentaryTileState extends State<MatchCommentaryWidget> {
  ExpandableController _expandableController;

  @override
  void initState() {
    super.initState();

    _expandableController = widget.controller ?? ExpandableController();
    _expandableController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SportWidgetBloc, SportWidgetState>(builder: (context, state) {
        if (state is SuccessUpdateLiveData) {
          return ExpandableNotifier(
            controller: _expandableController,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: Constants.kBorderRadius),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Expandable(
                          collapsed: MatchCommentaryTile(
                              state.uiModel.liveEventUiModels.first),
                          expanded: SizedBox(
                            height: _Constants.EXPANDED_HEIGHT,
                            child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              itemCount: state.uiModel.liveEventUiModels.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  MatchCommentaryTile(
                                      state.uiModel.liveEventUiModels[index]),
                                  SizedBox(height: 8)
                                ],
                              ),
                            ),
                          )),
                      Visibility(
                        visible: !_expandableController.expanded,
                        child: Positioned(
                          right: 8,
                          top: 4,
                          child: ExpandableButton(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: AppIcons.arrowDown,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _expandableController.expanded,
                        child: Positioned(
                          right: 8,
                          top: 4,
                          child: ExpandableButton(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: AppIcons.arrowUp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        } else
          return Container();
      });
}
