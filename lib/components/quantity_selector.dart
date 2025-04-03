// components/quantity_selector.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/view_model/quantity_controller.dart';

class QuantitySelector extends StatelessWidget {
  final double iconSize;
  final double textSize;
  final double buttonSize;
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const QuantitySelector({
    super.key,
    this.iconSize = 24,
    this.textSize = 16,
    this.buttonSize = 36,
    this.borderRadius = 12,
    this.backgroundColor = AppColors.grey,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final quantityController = Get.find<QuantityController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Minus button
        _QuantityButton(
          icon: Icons.remove,
          onPressed: quantityController.decrement,
          size: buttonSize,
          borderRadius: borderRadius,
          backgroundColor: backgroundColor,
          iconColor: iconColor,
          iconSize: iconSize,
        ),
        
        const SizedBox(width: 10),
        
        // Quantity display
        Obx(() => Text(
          quantityController.quantity.toString().padLeft(2, '0'),
          style: TextStyle(
            color: textColor, 
            fontSize: textSize,
          ),
        )),
        
        const SizedBox(width: 10),
        
        // Plus button
        _QuantityButton(
          icon: Icons.add,
          onPressed: quantityController.increment,
          size: buttonSize,
          borderRadius: borderRadius,
          backgroundColor: backgroundColor,
          iconColor: iconColor,
          iconSize: iconSize,
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final double borderRadius;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;

  const _QuantityButton({
    required this.icon,
    required this.onPressed,
    required this.size,
    required this.borderRadius,
    required this.backgroundColor,
    required this.iconColor,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor, size: iconSize),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }
}