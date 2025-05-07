import 'package:crafty_bay/features/common/controller/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/features/common/ui/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/assets_path.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        Get.find<MainBottomNavBarController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.find<MainBottomNavBarController>().backToHome();
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: Text('Category'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: 12,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 14,
            ),
            itemBuilder: (BuildContext context, int index) {
              return FittedBox(
                child: CategoryItem(
                  text: 'Electronics',
                  image: Image.asset(AssetsPath.electronicsCatPng),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
