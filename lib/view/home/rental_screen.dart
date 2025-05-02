

// rental_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/app_text_styles.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/expandable_tile.dart';
import 'package:sky_diving/components/quantity_selector.dart';
import 'package:sky_diving/components/title_appbar.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/view_model/rental_view_model.dart';

class RentalScreen extends StatelessWidget {
  const RentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(RentalViewModel());
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TitleAppBar(
        onBackPressed: () => Get.back(),
        title: "Rental",
      ),
      body: _buildBody(viewModel, screenSize),
    );
  }

  Widget _buildBody(RentalViewModel viewModel, Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        vertical: screenSize.height * 0.02,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(screenSize),
            SizedBox(height: 10,),
            _buildProductTitle(),
            _buildPriceAndQuantityRow(screenSize),
            _buildExpandableSections(screenSize.width),
            _buildAddToCartButton(),
            _buildProductDescription(screenSize.width),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(Size screenSize) {
    return Center(
      child: Image.asset(
        'assets/png/bag1.png',
        height: screenSize.height * 0.4,
        width: screenSize.width * 0.65,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildProductTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Skydiving Gear Rental",
          style: AppTextStyles.titleMedium,
        ),
        SizedBox(height: 4),
      ],
    );
  }

  Widget _buildPriceAndQuantityRow(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "US\$70.00",
          style: AppTextStyles.priceLarge.copyWith(color: AppColors.primaryColor),
        ),
        QuantitySelector(
          iconSize: screenSize.width * 0.05,
          textSize: screenSize.width * 0.045,
          buttonSize: screenSize.width * 0.09,
        ),
      ],
    );
  }

  Widget _buildExpandableSections(double screenWidth) {
    return Column(
      children: [
        SizedBox(height: 15),
        ExpandableTile(
          title: "Date of first day of rental",
          content: "Select your rental start date",
          screenWidth: screenWidth,
        ),
        SizedBox(height: 15),
        ExpandableTile(
          title: "Delivery Option",
          content: "Choose delivery method",
          screenWidth: screenWidth,
        ),
        SizedBox(height: 15),
        ExpandableTile(
          title: "Rental Period",
          content: "Select rental duration",
          screenWidth: screenWidth,
        ),
        SizedBox(height: 15),
        ExpandableTile(
          title: "Canopy Type and Size",
          content: "Select canopy specifications",
          screenWidth: screenWidth,
        ),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: AuthButton(
        buttonText: "Add to Cart",
        isLoading: false.obs,
        onPressed: () {
          // Handle add to cart
        },
      ),
    );
  }

  Widget _buildProductDescription(double screenWidth) {
    return Text(
      "Multiple Container choices from Javelin/Mirage/Glide/Vortex/Curv Please contact our office at 720-352-2151 to discuss a particular rental so we can match you with the proper size and type of equipment. Not all containers will fit all sizes and shape of individual. We may have more of one type available than others at any given time. We can not guarantee a particular type of container will be available. All our equipment is modern and freefly friendly. Most is less than 4 years old. All Containers are equipped with a MARD RSL. Skyhook or Similar. All Containers are equipped with Vigil or Cypres AAD. All Containers are equipped with Performance Designs Reserves Main Canopies range from 150 - 260 sizes. Mostly Sabre2, Sabre3 and Spectres. Some other types may be available from time to time.",
      style: AppTextStyles.bodySmall,
    );
  }
}