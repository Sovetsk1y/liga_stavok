import 'package:flutter_svg/svg.dart';

class AppIcons {
  static const String _APP_ICONS_PATH = 'assets/icons/';

  static String _iconPath(String iconName) =>
      _APP_ICONS_PATH + iconName + '.svg';

  static final exit = SvgPicture.asset(_iconPath('exit'));
  static final arrowDown = SvgPicture.asset(_iconPath('arrow_down'));
  static final arrowUp = SvgPicture.asset(_iconPath('arrow_up'));
}
