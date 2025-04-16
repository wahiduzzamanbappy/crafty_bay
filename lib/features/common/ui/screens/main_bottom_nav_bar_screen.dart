import 'package:crafty_bay/features/common/controller/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/features/categories/ui/screens/category_list_screen.dart';
import 'package:crafty_bay/features/home/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  static final name = '/main-nav-bar-screen';

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryListScreen(),
    const HomeScreen(),
    const HomeScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainBottomNavBarController>(
        builder: (controller) {
          return _screens[controller.selectedIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<MainBottomNavBarController>(
        builder: (controller) {
          return NavigationBar(
            selectedIndex: controller.selectedIndex,
            onDestinationSelected: controller.changeIndex,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.category), label: 'Category'),
              NavigationDestination(
                  icon: Icon(Icons.shopping_cart), label: 'Cart'),
              NavigationDestination(
                  icon: Icon(Icons.favorite_border), label: 'Wish'),
            ],
          );
        },
      ),
    );
  }
}
