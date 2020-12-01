import 'package:flutter/material.dart';

class Constants {
  static final BorderRadius kBorderRadius = BorderRadius.circular(20);

  static final RegExp kTrailingZerosCut = RegExp(r"([.]*0)(?!.*\d)");

  static const String TEAM_EMPTY_LOGO = 'assets/icons/team_empty_logo.svg';
  static const String CORNER_IMAGE = 'assets/images/corner.png';
}
