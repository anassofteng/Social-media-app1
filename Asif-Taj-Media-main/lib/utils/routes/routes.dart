import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/login/login_screen.dart';
import 'package:tech_media/view/signup/sign_up_screen.dart';
import 'package:tech_media/view/splash/splash_screen.dart';

import '../../view/DashBoard/DashBoardScreen.dart';
import '../../view/ForgotPassword/ForgotPassword.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.loginView:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.signupview:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteName.dashboard:
        return MaterialPageRoute(builder: (_) => const DashBoard());
      case RouteName.ForgotScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
