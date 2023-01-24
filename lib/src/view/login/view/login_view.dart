import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/circularProgressIndicator/circular_progress_indicator.dart';
import 'package:pera/src/core/components/sizedBox/custom_sized_box.dart';
import 'package:pera/src/core/components/text/text_with_googlefonts_widget.dart';
import 'package:pera/src/core/constants/enums/login_type.dart';
import 'package:pera/src/core/extensions/ui_extensions.dart';
import 'package:pera/src/core/route/app_router.dart';
import 'package:pera/src/view/home/home_view.dart';
import 'package:pera/src/view/login/model/user.dart';
import 'package:pera/src/view/login/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  final ValueNotifier<AppUser?> appUser;

  const LoginPage({Key? key, required this.appUser}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with BaseSingleton {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: context.padding5x,
        decoration: _boxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _loginBannerContainer(context),
            _bottomButtonColumn()
          ],
        ),
      ),
    );
  }

  Column _bottomButtonColumn() {
    return Column(
      children: <Widget>[
        socialLoginButton(
            "assets/images/google.png", constants.google, LoginType.google),
        CustomSizedBox(
          height: 15,
        ),
        socialLoginButton(
            "assets/images/apple.png", constants.apple, LoginType.google)
      ],
    );
  }

  Container _loginBannerContainer(BuildContext context) {
    return Container(
      padding: context.paddingVertical4x,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _iconLogo(),
              CustomSizedBox(width: 7),
              _textTitle(),
            ],
          ),
          CustomSizedBox(
            height: 20,
          ),
          _textSubtitle(),
        ],
      ),
    );
  }

  TextStyleGenerator _textSubtitle() {
    return TextStyleGenerator(
      text: constants.slogan,
      alignment: TextAlign.center,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    );
  }

  TextStyleGenerator _textTitle() {
    return TextStyleGenerator(
        text: constants.appTitle, fontWeight: FontWeight.bold, fontSize: 40);
  }

  Icon _iconLogo() {
    return Icon(
      icons.logo,
      color: colors.white,
      size: 35,
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(image: _backgroundImage());
  }

  DecorationImage _backgroundImage() {
    return const DecorationImage(
        image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover);
  }

  socialLoginButton(String path, String title, LoginType type) {
    return MaterialButton(
      color: colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      padding: context.paddingVertical2x,
      onPressed: () {
        switch (type) {
          case LoginType.google:
            dialog();
            authService.signInWithGoogle().then((user) {
              Navigator.pop(context);
              if (user != null) {
                widget.appUser.value = user;
                context.router.navigate(HomePage(user: widget.appUser));
              }
            });
            break;
          case LoginType.apple:
            dialog();
            authService.signInWithApple().then((user) {
              Navigator.pop(context);
              if (user != null) {
                widget.appUser.value = user;
                context.router.navigate(HomePage(user: widget.appUser));
              }
            });
            break;
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            path,
            height: 30,
          ),
          CustomSizedBox(
            width: 15,
          ),
          TextStyleGenerator(
              text: title, fontWeight: FontWeight.bold, fontSize: 20)
        ],
      ),
    );
  }

  dialogMessage(String message) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(message),
          );
        });
  }

  dialog() async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            content: Container(
                height: 50,
                alignment: Alignment.center,
                child: const CircularProgress()),
            title: Text(constants.oturumAciliyor),
          );
        });
  }
}
