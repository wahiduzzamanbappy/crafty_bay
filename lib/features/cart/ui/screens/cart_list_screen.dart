import 'package:crafty_bay/features/cart/ui/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/app_color.dart';
import '../../../../core/widgets/cenetred_circular_progress_indicator.dart';
import '../../../common/controller/main_bottom_nav_bar_controller.dart';
import '../controllers/cart_list_controller.dart';
import '../../data/model/cart_item_model.dart';
import '../widgets/cart_item_card.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  final CartListController _cartListController = Get.find<CartListController>();

  @override
  void initState() {
    super.initState();
    _cartListController.getCartList();
  }

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
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('Cart list'),
        ),
        body: GetBuilder<CartListController>(builder: (controller) {
          if (controller.getCartListInProgress) {
            return const CenteredCircularProgressIndicator();
          }

          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: controller.cartItemList.length,
                    itemBuilder: (context, index) {
                      CartItemModel cartItem = controller.cartItemList[index];
                      return CartItemCard(cartItem: cartItem);
                    },
                  ),
                ),
              ),
              Container(
                child: _buildTotalPriceSection(),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTotalPriceSection() {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Price'),
              Text(
                '\$${_cartListController.totalPrice}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(
                  context,
                  PaymentScreen.name,
                  arguments: _cartListController.totalPrice.toDouble(),
                );
              },
              child: const Text('Checkout'),
            ),
          )
        ],
      ),
    );
  }
}
