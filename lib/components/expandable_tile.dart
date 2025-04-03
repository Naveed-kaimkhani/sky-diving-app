// components/expandable_tile.dart
import 'package:flutter/material.dart';
import 'package:sky_diving/components/app_text_styles.dart';
import 'package:sky_diving/constants/app_colors.dart';

class ExpandableTile extends StatefulWidget {
  final String title;
  final String content;
  final double screenWidth;

  const ExpandableTile({
    super.key,
    required this.title,
    required this.content,
    required this.screenWidth,
  });

  @override
  State<ExpandableTile> createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: AppTextStyles.bodyMedium,
        ),
        trailing: Icon(
          _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: AppColors.primaryColor,
          size: widget.screenWidth * 0.06,
        ),
        iconColor: AppColors.primaryColor,
        collapsedIconColor: AppColors.primaryColor,
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: EdgeInsets.all(widget.screenWidth * 0.03),
            child: Text(
              widget.content,
              style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}