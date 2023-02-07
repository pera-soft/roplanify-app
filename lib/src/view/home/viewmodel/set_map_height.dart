import 'dart:ui';

import 'package:flutter/material.dart';

class SetMapHeight extends ChangeNotifier {
  double deviceHeight =
      window.physicalSize.longestSide / window.devicePixelRatio;
  late double mapHeight = deviceHeight;
  void setDeviceHeight(double height) {
    if (deviceHeight - height > deviceHeight / 2) {
      mapHeight = deviceHeight - height;
    }
    notifyListeners();
  }
}
