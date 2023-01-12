import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/circularProgressIndicator/circular_progress_indicator.dart';
import 'package:pera/src/core/components/text/text_with_googlefonts_widget.dart';
import 'package:pera/src/core/extensions/ui_extensions.dart';

class LoadingPopup extends StatefulWidget {
  const LoadingPopup({Key? key}) : super(key: key);

  @override
  State<LoadingPopup> createState() => _LoadingPopupState();
}

class _LoadingPopupState extends State<LoadingPopup> with BaseSingleton {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        padding: context.padding5x,
        height: context.height / 2,
        width: context.width - 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _textRoute(),
            _imageRoute(),
            const CircularProgress(),
          ],
        ),
      ),
    );
  }

  TextStyleGenerator _textRoute() {
    return TextStyleGenerator(
      text: constants.rotaOptimizeEdiliyor,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      alignment: TextAlign.center,
    );
  }

  Image _imageRoute() {
    return Image.asset(
      "assets/images/route.png",
      fit: BoxFit.cover,
    );
  }
}
