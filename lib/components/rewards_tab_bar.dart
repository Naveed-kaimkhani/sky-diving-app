import 'package:flutter/material.dart';
import 'package:sky_diving/constants/app_colors.dart';

class RewardsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Now 4 tabs to match the image
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent, // Light grey background for the tab bar
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            child: TabBar(
                dividerColor: Colors.transparent,
          // labelStyle: TextStyle(
          //   fontSize: 10
          // ),
              // isScrollable: true, // In case tabs don't fit
              // labelPadding: EdgeInsets.symmetric(horizontal: 16), // Space between tabs
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(6), // Rounded indicator
                color:AppColors.primaryColor, // White background for selected tab
              ),
              labelColor: Colors.black, // Text color for selected tab
              unselectedLabelColor: Colors.white, // Text color for unselected tabs
              tabs: [
                Tab(text: '   All   '),
                Tab(text: ' Claimed '),
                Tab(text: ' Pending  '),
              
              ],
            ),
          ),
          SizedBox(height: 16), // Space between tab bar and content
          Expanded(
            child: TabBarView(
              children: [
                // Your content for each tab
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


