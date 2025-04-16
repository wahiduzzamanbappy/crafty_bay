import 'package:crafty_bay/app/assets_path.dart';
import 'package:crafty_bay/features/home/ui/widgets/home_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/ui/widgets/category_item.dart';
import '../../../common/ui/widgets/product_card.dart';
import '../widgets/app_bar_action_button.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static final name = '/home-screen';

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
              _buildSearchBarTextField(),
              const SizedBox(height: 16),
              HomeCarouselSlider(),
              const SizedBox(height: 32),
              SectionHeader(
                title: 'All Category',
                onTap: () {
                  //Get.find<MainBottomNavBarController>().moveToCategory;
                },
              ),
              _buildCategorySection(),
              const SizedBox(height: 16),
              SectionHeader(
                title: 'Popular',
                onTap: () {},
              ),
              _buildProductSection(),
              const SizedBox(height: 16),
              SectionHeader(

                title: 'Special',
                onTap: () {},
              ),
              _buildProductSection(),
              const SizedBox(height: 16),
              SectionHeader(
                title: 'New',
                onTap: () {},
              ),
              _buildProductSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryItem(
            text: 'Electronics',
            image: Image.asset(AssetsPath.electronicsCatPng),
          ),
          SizedBox(width: 16),
          CategoryItem(
            text: 'Foods',
            image: Image.asset(AssetsPath.foodCatPng),
          ),
          SizedBox(width: 16),
          CategoryItem(
            text: "Furniture's",
            image: Image.asset(AssetsPath.furnitureCatPng),
          ),
          SizedBox(width: 16),
          CategoryItem(
            text: 'Fashions',
            image: Image.asset(AssetsPath.fashionCatPng),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBarTextField() {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
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
