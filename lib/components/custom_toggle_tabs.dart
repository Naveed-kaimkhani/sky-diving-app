import 'package:flutter/material.dart';
import 'package:sky_diving/components/label_text.dart';
import 'package:sky_diving/constants/app_colors.dart';
class CustomToggleTabs extends StatefulWidget {
  const CustomToggleTabs({super.key});

  @override
  _CustomToggleTabsState createState() => _CustomToggleTabsState();
}

class _CustomToggleTabsState extends State<CustomToggleTabs> {
  int selectedIndex = 0; // 0 = Moderator, 1 = Team Member

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390, // Adjust based on your UI
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: Row(
        children: [
          _buildTab("Moderator", 0),
          _buildTab("Team Member", 1),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: isSelected
                ?  LinearGradient(
                    colors:AppColors.appGradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: 
          LabelText(text: text,weight: FontWeight.w500,),
          // Text(
          //   text,
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w500,
          //     color: isSelected ? Colors.black : Colors.black87,
          //   ),
          // ),
        ),
      ),
    );
  }
}
