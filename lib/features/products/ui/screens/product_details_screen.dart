import 'package:crafty_bay/features/products/ui/widget/product_image_carousel_slider.dart';
import 'package:flutter/material.dart';

import '../widget/product_increment_decrement_counter.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  static const String name = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Column(
        children: [
          ProductImageCarouselSlider(),
          Expanded(child: Column()),
          ProductIncrementDecrementCounter(),
          
        ],
      ),
    );
  }
}
