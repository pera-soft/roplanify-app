import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/circularProgressIndicator/circular_progress_indicator.dart';
import 'package:pera/src/core/components/sizedBox/custom_sized_box.dart';
import 'package:pera/src/core/components/text/text_with_googlefonts_widget.dart';
import 'package:pera/src/core/route/app_router.dart';
import 'package:pera/src/view/login/model/user.dart';
import 'package:pera/src/view/login/service/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with BaseSingleton {
  ValueNotifier<AppUser?> user = ValueNotifier(null);
  AuthService authService = AuthService.instance;

  @override
  void initState() {
    super.initState();
    checkCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Image.asset(
              "res/graphic/logo.png",
              height: 131.7,
              width: 128.4,
            ),*/
            TextStyleGenerator(
              text: constants.appTitle,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            CustomSizedBox(height: 50),
            const CircularProgress()
          ],
        ),
      ),
    );
  }

  checkCurrentUser() {
    authService.currentUser().then((currentUser) {
      Timer(const Duration(seconds: 3), () {
        if (currentUser != null) {
          user.value = currentUser;
          context.router.navigate(HomePage(user: user));
        } else {
          context.router.navigate(LoginRoute(appUser: user));
        }
      });
    });
  }
}
