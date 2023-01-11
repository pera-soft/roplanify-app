import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/sizedBox/custom_sized_box.dart';
import 'package:pera/src/core/components/text/text_withgooglefonts_widet.dart';
import 'package:pera/src/core/extensions/ui_extensions.dart';
import 'package:pera/src/view/home/home_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with BaseSingleton {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: context.padding5x,
        decoration: _boxdecoration(),
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
        socialLoginButton("assets/images/google.png", constants.google),
        CustomSizedBox(
          height: 15,
        ),
        socialLoginButton("assets/images/apple.png", constants.apple)
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
          _textsubTitle(),
        ],
      ),
    );
  }

  TextStyleGenerator _textsubTitle() {
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

  BoxDecoration _boxdecoration() {
    return BoxDecoration(image: _backgroundImage());
  }

  DecorationImage _backgroundImage() {
    return const DecorationImage(
        image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover);
  }

  socialLoginButton(String path, String title) {
    return MaterialButton(
      color: colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      padding: context.paddingVertical2x,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Home()));
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
}
