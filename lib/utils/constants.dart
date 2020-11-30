import 'package:flutter/material.dart';

class Constants {
  static final BorderRadius kBorderRadius = BorderRadius.circular(20);

  //regexps
  static final RegExp kTrailingZerosCut = RegExp(r"([.]*0)(?!.*\d)");

  //assets
  static const String TEAM_EMPTY_LOGO = 'assets/icons/team_empty_logo.svg';
}
