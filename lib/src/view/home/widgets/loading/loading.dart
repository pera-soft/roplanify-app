import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/circularProgressIndicator/circular_progress_indicator.dart';
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
            Text(
              constants.rotaOptimizeEdiliyor,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Image.asset(
              "lib/src/assets/images/route.png",
              fit: BoxFit.cover,
            ),
            const CircularProgress(),
          ],
        ),
      ),
    );
  }
}
