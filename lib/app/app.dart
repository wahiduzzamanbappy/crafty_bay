import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/app/app_routes.dart';
import 'package:crafty_bay/app/controller_binder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


class CraftyBay extends StatefulWidget {
  const CraftyBay({super.key});

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.themeColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.themeColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.themeColor),
            ),
            hintStyle:
                TextStyle(fontWeight: FontWeight.w400, color: Colors.grey)),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            foregroundColor: Colors.white,
            backgroundColor: AppColors.themeColor,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.white
        )
      ),

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en'),
      supportedLocales: const [Locale('en'), Locale('bn')],
      initialBinding: ControllerBinder(),
    );
  }
}
