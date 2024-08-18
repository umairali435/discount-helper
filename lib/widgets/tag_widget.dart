import 'package:discount_helper/utils/colors.dart';
import 'package:flutter/material.dart';

class TagDiscount extends StatelessWidget {
  final VoidCallback onPressed;
  final String discount;
  final Color color;
  const TagDiscount({
    super.key,
    required this.discount,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          "$discount%",
          style: TextStyle(
            color: color == AppColors.primaryColor ? AppColors.whiteColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
