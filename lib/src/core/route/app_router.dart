import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pera/src/view/home/home_view.dart';
import 'package:pera/src/view/login/model/user.dart';
import 'package:pera/src/view/login/view/login_view.dart';
import 'package:pera/src/view/splash/view/splash.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
        page: SplashScreen, path: "splash", name: "Splash", initial: true),
    AutoRoute(page: LoginPage, path: "login"),
    AutoRoute(page: Home, path: "home", name: "HomePage"),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
