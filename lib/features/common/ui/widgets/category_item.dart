import 'package:flutter/material.dart';
import '../../../../app/app_color.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.text, required this.image});

  final String text;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () {},
      child: SizedBox(
        width: 140,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 120,
              width: 140,
              decoration: BoxDecoration(
                color: AppColors.themeColor.withOpacity(0.15),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                image: DecorationImage(
                  image: image.image,
                  fit: BoxFit.cover,
                  scale: 25,
                ),
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                color: AppColors.themeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
