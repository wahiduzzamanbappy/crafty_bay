import 'package:crafty_bay/features/common/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:crafty_bay/features/products/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/features/products/ui/screens/product_list_Screen.dart';
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
    }else if (settings.name == MainBottomNavBarScreen.name) {
      route = MainBottomNavBarScreen();
    } else if (settings.name == ProductListScreen.name) {
      final String category = settings.arguments as String;
      route = ProductListScreen(category: category);
    } else if (settings.name == ProductDetailsScreen.name) {
      route = ProductDetailsScreen();
    }
    return MaterialPageRoute(builder: (ctx) => route);
  }
}
