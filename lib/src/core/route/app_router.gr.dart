// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    Splash.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: LoginPage(
          key: args.key,
          appUser: args.appUser,
        ),
      );
    },
    HomePage.name: (routeData) {
      final args = routeData.argsAs<HomePageArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: Home(
          key: args.key,
          user: args.user,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'splash',
          fullMatch: true,
        ),
        RouteConfig(
          Splash.name,
          path: 'splash',
        ),
        RouteConfig(
          LoginRoute.name,
          path: 'login',
        ),
        RouteConfig(
          HomePage.name,
          path: 'home',
        ),
      ];
}

/// generated route for
/// [SplashScreen]
class Splash extends PageRouteInfo<void> {
  const Splash()
      : super(
          Splash.name,
          path: 'splash',
        );

  static const String name = 'Splash';
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    required ValueNotifier<AppUser?> appUser,
  }) : super(
          LoginRoute.name,
          path: 'login',
          args: LoginRouteArgs(
            key: key,
            appUser: appUser,
          ),
        );

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.appUser,
  });

  final Key? key;

  final ValueNotifier<AppUser?> appUser;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, appUser: $appUser}';
  }
}

/// generated route for
/// [Home]
class HomePage extends PageRouteInfo<HomePageArgs> {
  HomePage({
    Key? key,
    required ValueNotifier<AppUser?> user,
  }) : super(
          HomePage.name,
          path: 'home',
          args: HomePageArgs(
            key: key,
            user: user,
          ),
        );

  static const String name = 'HomePage';
}

class HomePageArgs {
  const HomePageArgs({
    this.key,
    required this.user,
  });

  final Key? key;

  final ValueNotifier<AppUser?> user;

  @override
  String toString() {
    return 'HomePageArgs{key: $key, user: $user}';
  }
}
