import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../app/assets_path.dart';
import '../../../../core/widgets/cenetred_circular_progress_indicator.dart';
import '../../../common/controller/category_controller.dart';
import '../../../common/controller/main_bottom_nav_bar_controller.dart';
import '../../../common/date/models/category_model.dart';
import '../../../common/ui/widgets/category_item.dart';
import '../widgets/app_bar_action_button.dart';
import '../widgets/home_carousel_slider.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSearchTextField(),
              const SizedBox(height: 16),
              const HomeCarouselSlider(),
              const SizedBox(height: 16),
              SectionHeader(
                title: 'All Category',
                onTapSeeAll: () {
                  Get.find<MainBottomNavBarController>().moveToCategory();
                },
              ),
              const SizedBox(height: 16),
              _buildCategoriesSection(),
              const SizedBox(height: 16),
              SectionHeader(
                title: 'Popular',
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 16),
              _buildProductSection(),
              const SizedBox(height: 16),
              SectionHeader(
                title: 'Special',
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 16),
              _buildProductSection(),
              const SizedBox(height: 16),
              SectionHeader(
                title: 'New',
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 16),
              _buildProductSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductSection() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // ProductCard(),
          // ProductCard(),
          // ProductCard(),
          // ProductCard(),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        if (controller.isInitialLoading) {
          return const SizedBox(
            height: 100,
            child: CenteredCircularProgressIndicator(),
          );
        }

        List<CategoryModel> list = controller.categoryList.length > 10
            ? controller.categoryList.sublist(0, 10)
            : controller.categoryList;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: list.map((e) {
              return CategoryItem(categoryModel: e);
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildSearchTextField() {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetsPath.logoNavSvg),
      actions: [
        AppBarActionButton(
          icon: Icons.person_outline,
          onTap: () {},
        ),
        const SizedBox(width: 8),
        AppBarActionButton(
          icon: Icons.call,
          onTap: () {},
        ),
        const SizedBox(width: 8),
        AppBarActionButton(
          icon: Icons.notifications_active_outlined,
          onTap: () {},
        ),
      ],
    );
  }
}
