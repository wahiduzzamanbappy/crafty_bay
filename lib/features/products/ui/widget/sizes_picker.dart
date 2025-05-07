import 'package:crafty_bay/app/app_color.dart';
import 'package:flutter/material.dart';

class SizesPicker extends StatefulWidget {
  const SizesPicker({super.key, required this.size, required this.onChange});

  final List<String> size;
  final Function(String) onChange;

  @override
  State<SizesPicker> createState() => _SizesPickerState();
}

class _SizesPickerState extends State<SizesPicker> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.size.length,
            itemBuilder: (context, index) {
              String color = widget.size[index];
              return GestureDetector(
                onTap: () {
                  selectedSize = color;
                  setState(() {});
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: selectedSize == color ? AppColors.themeColor : null,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.only(right: 8),
                  alignment: Alignment.center,
                  child: Text(
                    color,
                    style: TextStyle(
                      color: selectedSize == color ? Colors.white : null,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
