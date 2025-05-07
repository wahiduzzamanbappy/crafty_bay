import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/features/products/ui/widget/product_image_carousel_slider.dart';
import 'package:flutter/material.dart';
import '../widget/colors_picker.dart';
import '../widget/product_increment_decrement_counter.dart';
import '../widget/sizes_picker.dart';

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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductImageCarouselSlider(),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                      ),
                                      Text('4.5'),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Reviews',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: AppColors.themeColor
                                                .withOpacity(0.9),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ProductIncrementDecrementCounter(),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ColorsPicker(
                          color: ['Red', 'Grey', 'Yellow', 'Black'],
                          onChange: (selectedColor) {},
                        ),
                        const SizedBox(height: 16),
                        SizesPicker(
                          size: ['S', 'M', 'L', 'XL', '2XL'],
                          onChange: (selectedSize) {},
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and "
                              "typesetting industry. Lorem Ipsum has been the industry's "
                              "standard dummy text ever since the 1500s, when an unknown "
                              "printer took a galley of type and scrambled it to make a "
                              "type specimen book.",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildPriceAndAddToCartSection(),
        ],
      ),
    );
  }

  Widget _buildPriceAndAddToCartSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          topLeft: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Price',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '£1000',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
