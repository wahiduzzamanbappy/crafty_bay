import 'package:crafty_bay/features/common/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        /*leading: IconButton(onPressed: () {
          Get.find
        }, icon: Icon(Icons.arrow_back_ios_new),),*/
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 30,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 0,
          ),
          itemBuilder: (context, index) {
            return FittedBox(
              child: ProductCard(),
            );
          },
        ),
      ),
    );
  }
}
