import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/sizedBox/custom_sized_box.dart';
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
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/src/assets/images/background.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: context.paddingVertical4x,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        icons.logo,
                        color: colors.white,
                        size: 35,
                      ),
                      CustomSizedBox(width: 7),
                      Text(
                        constants.appTitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                    ],
                  ),
                  CustomSizedBox(
                    height: 20,
                  ),
                  Text(
                    constants.slogan,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                socialLoginButton(
                    "lib/src/assets/images/google.png", constants.google),
                CustomSizedBox(
                  height: 15,
                ),
                socialLoginButton(
                    "lib/src/assets/images/apple.png", constants.apple)
              ],
            )
          ],
        ),
      ),
    );
  }

  socialLoginButton(String path, String title) {
    return MaterialButton(
      color: colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      padding: context.paddingVertical2x,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const Home()));
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
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      ),
    );
  }
}
