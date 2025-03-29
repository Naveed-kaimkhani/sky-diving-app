
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/constants/app_colors.dart';

class RentalScreen extends StatefulWidget {
  const RentalScreen({super.key});

  @override
  State<RentalScreen> createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizing
    final imageHeight = screenHeight * 0.4; // 40% of screen height
    final imageWidth = screenWidth * 0.65; // 65% of screen width
    final horizontalPadding = screenWidth * 0.05; // 5% of screen width
    final verticalPadding = screenHeight * 0.02; // 2% of screen height
    final titleFontSize = screenWidth * 0.045; // 4.5% of screen width
    final priceFontSize = screenWidth * 0.06; // 6% of screen width
    final descriptionFontSize = screenWidth * 0.035; // 3.5% of screen width

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Rental",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.05)), // 5% of screen width
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white, size: screenWidth * 0.06),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Centered Image
              Center(
                child: Image.asset(
                  'assets/png/bag1.png',
                  height: imageHeight,
                  width: imageWidth,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Title
              Text(
                "Skydiving Gear Rental",
                style: TextStyle(color: Colors.white, fontSize: titleFontSize),
              ),
              SizedBox(height: screenHeight * 0.01),

              // Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "US\$70.00",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: priceFontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove,
                            color: Colors.white, size: screenWidth * 0.06),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        quantity.toString().padLeft(2, '0'),
                        style: TextStyle(
                            color: Colors.white, fontSize: titleFontSize),
                      ),
                      IconButton(
                        icon: Icon(Icons.add,
                            color: Colors.white, size: screenWidth * 0.06),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),

              // Expandable Sections
              ExpandableTile(
                  title: "Date of first day of rental",
                  screenWidth: screenWidth),
              SizedBox(height: screenHeight * 0.015),
              ExpandableTile(
                  title: "Delivery Option", screenWidth: screenWidth),
              SizedBox(height: screenHeight * 0.015),
              ExpandableTile(title: "Rental Period", screenWidth: screenWidth),
              SizedBox(height: screenHeight * 0.015),
              ExpandableTile(
                  title: "Canopy Type and Size", screenWidth: screenWidth),

              SizedBox(height: screenHeight * 0.02),
              AuthButton(
                  buttonText: "Add to Cart",
                  isLoading: false.obs,
                  onPressed: () {}),
              SizedBox(height: screenHeight * 0.04),

              Text(
                "Multiple Container choices from Javelin/Mirage/Glide/Vortex/Curv Please contact our office at 720-352-2151 to discuss a particular rental so we can match you with the proper size and type of equipment. Not all containers will fit all sizes and shape of individual. We may have more of one type available than others at any given time. We can not guarantee a particular type of container will be available. All our equipment is modern and freefly friendly. Most is less than 4 years old. All Containers are equipped with a MARD RSL. Skyhook or Similar. All Containers are equipped with Vigil or Cypres AAD. All Containers are equipped with Performance Designs Reserves Main Canopies range from 150 - 260 sizes. Mostly Sabre2, Sabre3 and Spectres. Some other types may be available from time to time.",
                style: TextStyle(
                    color: Colors.white, fontSize: descriptionFontSize),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandableTile extends StatefulWidget {
  final String title;
  final double screenWidth;

  const ExpandableTile(
      {super.key, required this.title, required this.screenWidth});

  @override
  State<ExpandableTile> createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(widget.title,
            style: TextStyle(
                color: Colors.white,
                fontSize: widget.screenWidth * 0.04)), // 4% of screen width
        trailing: Icon(
          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: Colors.green,
          size: widget.screenWidth * 0.06, // 6% of screen width
        ),
        iconColor: AppColors.primaryColor,
        collapsedIconColor: AppColors.primaryColor,
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding:
                EdgeInsets.all(widget.screenWidth * 0.03), // 3% of screen width
            child: Text(
              "More details about ",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: widget.screenWidth * 0.035), // 3.5% of screen width
            ),
          ),
        ],
      ),
    );
  }
}
