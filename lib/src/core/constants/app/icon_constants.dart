import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconConstants {
  static IconConstants? _instance;

  static IconConstants get instance {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = IconConstants.init();
      return _instance!;
    }
  }

  IconConstants.init();

  IconData get logo => FontAwesomeIcons.locationDot;

  IconData get navigation => Icons.navigation;

  IconData get addLocationOutlined => Icons.add_location_outlined;

  IconData get menu => Icons.menu;

  IconData get search => Icons.search;

  IconData get mic => Icons.mic;

  IconData get xmark => FontAwesomeIcons.xmark;

  IconData get angleRight => FontAwesomeIcons.angleRight;

  IconData get logOut => Icons.power_settings_new;

  IconData get truck => FontAwesomeIcons.truck;
}
