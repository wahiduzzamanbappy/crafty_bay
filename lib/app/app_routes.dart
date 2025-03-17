import 'package:flutter/material.dart';
import '../features/auth/ui/screens/sign_in_screen.dart';
import '../features/auth/ui/screens/sign_up_screen.dart';
import '../features/auth/ui/screens/splash_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    late Widget route;
    if (settings.name == SplashScreen.name) {
      route = SplashScreen();
    } else if (settings.name == SignInScreen.name) {
      route = SignInScreen();
    } else if (settings.name == SignUpScreen.name) {
      route = SignUpScreen();
    }
    return MaterialPageRoute(builder: (bappy) => route);
  }
}
