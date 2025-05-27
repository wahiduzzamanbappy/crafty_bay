import 'package:crafty_bay/features/reviews/ui/screens/review_screens.dart';
import 'package:crafty_bay/features/wishlist/ui/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import '../features/auth/ui/screens/sign_in_screen.dart';
import '../features/auth/ui/screens/sign_up_screen.dart';
import '../features/auth/ui/screens/splash_screen.dart';
import '../features/auth/ui/screens/verify_otp_screen.dart';
import '../features/cart/ui/screens/payment_screen.dart';
import '../features/common/date/models/category_model.dart';
import '../features/common/ui/screens/main_bottom_nav_bar_screen.dart';
import '../features/products/ui/screens/product_details_screen.dart';
import '../features/products/ui/screens/product_list_Screen.dart';
import '../features/reviews/ui/screens/add_new_review.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    late Widget route;
    if (settings.name == SplashScreen.name) {
      route = const SplashScreen();
    } else if (settings.name == SignInScreen.name) {
      route = const SignInScreen();
    } else if (settings.name == SignUpScreen.name) {
      route = const SignUpScreen();
    } else if (settings.name == VerifyOtpScreen.name) {
      String email = settings.arguments as String;
      route = VerifyOtpScreen(email: email);
    } else if (settings.name == MainBottomNavBarScreen.name) {
      route = const MainBottomNavBarScreen();
    }  else if (settings.name == ReviewScreens.name) {
      route = const ReviewScreens();
    } else if (settings.name == AddNewReviewScreen.name) {
      route = const AddNewReviewScreen();
    } else if (settings.name == ProductListScreen.name) {
      final category = settings.arguments as CategoryModel;
      route = ProductListScreen(category: category);
    } else if (settings.name == ProductDetailsScreen.name) {
      String productId = settings.arguments as String;
      route = ProductDetailsScreen(productId: productId);
    } else if (settings.name == PaymentScreen.name) {
      double productId = settings.arguments as double;
      route = PaymentScreen(paymentAmount: productId);
    } else if (settings.name == WishListScreen.name) {
      route = const WishListScreen();
    }

    return MaterialPageRoute(
      builder: (context) {
        return route;
      },
    );
  }
}