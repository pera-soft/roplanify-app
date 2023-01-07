import 'package:pera/src/core/constants/app/app_constants.dart';
import 'package:pera/src/core/constants/app/icon_constants.dart';
import 'package:pera/src/core/theme/color/my_colors.dart';
import 'package:pera/src/core/theme/my_theme.dart';
import 'package:pera/src/core/theme/text/my_texts.dart';

abstract class BaseSingleton {
  MyColors get colors => MyColors.instance;

  MyTexts get texts => MyTexts.instance;

  MyTheme get theme => MyTheme.instance;

  AppConstants get constants => AppConstants.instance;

  IconConstants get icons => IconConstants.instance;
}
