import 'package:crafty_bay/features/reviews/ui/screens/review_screens.dart';
import 'package:crafty_bay/features/wishlist/ui/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/app_color.dart';
import '../../../../core/widgets/cenetred_circular_progress_indicator.dart';
import '../../../../core/widgets/show_snack_bar_message.dart';
import '../../../auth/ui/controllers/auth_controller.dart';
import '../../../auth/ui/screens/sign_in_screen.dart';
import '../../../common/controller/add_to_cart_controller.dart';
import '../../controllers/product_details_controller.dart';
import '../widget/colors_picker.dart';
import '../widget/increment_decrement_counter_wiudgets.dart';
import '../widget/product_image_carousel_slider.dart';
import '../widget/size_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  static const String name = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsController _productDetailsController =
      ProductDetailsController();
  final AddToCartController _addToCartController = AddToCartController();

  String? _selectedColor;
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    _productDetailsController.getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: GetBuilder(
        init: _productDetailsController,
        builder: (controller) {
          if (controller.inProgress) {
            return const CenteredCircularProgressIndicator();
          }

          if (controller.errorMessage != null) {
            return Center(
              child: Text(controller.errorMessage!),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImageCarouselSlider(
                        imageList: controller.product.photos,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.product.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 20,
                                              ),
                                              Text(
                                                '${controller.product.rating}',
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(context, ReviewScreens.name);
                                            },
                                            child: const Text('Reviews'),
                                          ),
                                          Card(
                                            color: AppColors.themeColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(context, WishListScreen.name);
                                                },
                                                icon: Icon(
                                                  Icons.favorite_border,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IncrementDecrementCounterWidget(
                                  onChange: (int value) {
                                    print(value);
                                  },
                                ),
                              ],
                            ),
                            if (controller.product.colors.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  ColorPicker(
                                    colors: controller.product.colors,
                                    onChange: (selectedColor) {
                                      _selectedColor = selectedColor;
                                    },
                                  ),
                                ],
                              ),
                            Visibility(
                              visible: controller.product.sizes.isNotEmpty,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  SizePicker(
                                    sizes: controller.product.sizes,
                                    onChange: (selectedSize) {
                                      _selectedSize = selectedSize;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.product.description,
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildPriceAndAddToCartSection(
                  controller.product.sizes.isNotEmpty,
                  controller.product.colors.isNotEmpty),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPriceAndAddToCartSection(
      bool isSizeAvailable, bool isColorAvailable) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price'),
              Text(
                '\$1000',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: GetBuilder(
                init: _addToCartController,
                builder: (controller) {
                  return Visibility(
                    visible: controller.inProgress == false,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (isSizeAvailable && _selectedSize == null) {
                          showSnackBarMessage(
                            context,
                            'Please select your size',
                            true,
                          );
                          return;
                        }
                        if (isColorAvailable && _selectedColor == null) {
                          showSnackBarMessage(
                              context, 'Please select your color', true);
                          return;
                        }

                        if (Get.find<AuthController>().isValidUser() == false) {
                          Get.to(() => const SignInScreen());
                          return;
                        }

                        final bool isSuccess = await _addToCartController
                            .addToCart(_productDetailsController.product.id);
                        if (isSuccess) {
                          showSnackBarMessage(context, 'Added to cart');
                        } else {
                          showSnackBarMessage(context,
                              _addToCartController.errorMessage!, true);
                        }
                      },
                      child: const Text('Add to Cart'),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
