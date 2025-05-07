import 'package:crafty_bay/app/app_color.dart';
import 'package:flutter/material.dart';

class ProductIncrementDecrementCounter extends StatefulWidget {
  const ProductIncrementDecrementCounter({super.key});

  @override
  State<ProductIncrementDecrementCounter> createState() =>
      _ProductIncrementDecrementCounterState();
}

class _ProductIncrementDecrementCounterState
    extends State<ProductIncrementDecrementCounter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (count <= 1) return;
            count--;
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.themeColor,
                borderRadius: BorderRadius.circular(4)),
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (count >= 10) return;
            count++;
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.themeColor,
                borderRadius: BorderRadius.circular(4)),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
