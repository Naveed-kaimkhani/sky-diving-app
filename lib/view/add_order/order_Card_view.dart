import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/apply_coupon_button.dart';
import 'package:sky_diving/view_model/quantity_controller.dart';
import '../../components/app_text_styles.dart';
import '../../components/auth_button.dart';
import '../../components/custom_textfield.dart';
import '../../components/quantity_selector.dart';
import '../../components/title_appbar.dart';
import '../../constants/app_colors.dart';
import '../../constants/routes_name.dart';
import '../../view_model/rental_view_model.dart';

class AddOrderCard extends StatefulWidget {
  AddOrderCard({super.key});

  @override
  State<AddOrderCard> createState() => _AddOrderCardState();
}

class _AddOrderCardState extends State<AddOrderCard> {
  final quantityController = Get.find<QuantityController>();
  final viewModel = Get.find<RentalViewModel>();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TitleAppBar(
        onBackPressed: () => Get.back(),
        title: "Add Item",
      ),
      body: _buildBody(screenSize),
    );
  }
}

Widget _buildAddToCartButton() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: AuthButton(
      buttonText: "Continue Payment",
      isLoading: false.obs,
      onPressed: () {
        Get.toNamed(RouteName.checkOut);
        // Handle add to cart
      },
    ),
  );
}

Widget _buildBody(Size screenSize) {
  return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        // vertical: screenSize.height * 0.01,
      ),
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildProductImage(screenSize),
        SizedBox(
          height: 10,
        ),
        _buildProductTitle(screenSize),
        _buildPriceAndQuantityRow(screenSize),
        SizedBox(
          height: 30,
        ),
        buildSelectorValue(screenSize),
        buildGiftIt(screenSize),
        _buildAddToCartButton()
      ])));
}

Widget buildGiftIt(Size screenSize) {
  final TextEditingController couponController = TextEditingController();
  final viewModel = Get.find<RentalViewModel>();
  calculateSubTotal();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 8),
      Text(
        "How To Get It",
        style: AppTextStyles.titleMedium,
      ),
      SizedBox(height: 8),

      // TextField and Button Row
      Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: couponController,
              hintText: "Add Coupon or gift card",
              onChanged: (val) {},
            ),
          ),
          SizedBox(width: 8),
          ApplyCouponButton(couponController: couponController),
        ],
      ),

      SizedBox(height: 15),

      Obx(() => calculatedCartTill(
            "Subtotal",
            '\$${viewModel.subtotal.value}',
            screenSize,
          )),

      calculatedCartTill("Estimated taxes", "\$0", screenSize),

      Obx(() => calculatedCartTill(
            "Estimated order total",
            '\$${viewModel.subtotal.value}',
            screenSize,
          )),
    ],
  );
}

String calculateSubTotal() {
  final quantityController = Get.find<QuantityController>();
  final viewModel = Get.find<RentalViewModel>();

  int baseCost = viewModel.cost.value * quantityController.quantity.value;

  int shippingCost = viewModel.addCardModel.value.deliveryOption ==
          'Shipped to your location contact us at 720-352-2151 to discuss'
              ' delivery option, Fee is for roundTrip shipping (+\$150.00)'
      ? 150
      : 0;

  int rentalExtra = viewModel.extraRentalCost.value;

  viewModel.subtotal.value = baseCost + shippingCost + rentalExtra;
  return viewModel.subtotal.value.toString();
}

Widget calculatedCartTill(String title, String subTitle, Size screenSize) {
  return Padding(
    padding: EdgeInsets.only(bottom: screenSize.height * 0.015),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.s,
      children: [
        Text(title, style: AppTextStyles.bodyMedium),
        Text(subTitle, style: AppTextStyles.bodyMedium),
      ],
    ),
  );
}

Widget buildSelectorValue(Size screenSize) {
  final viewModel = Get.find<RentalViewModel>();
  viewModel.cardOnj();
  return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cartTill("Skydiving Gear Rental", "\$70.00", screenSize),
          cartTill("Date of First Day of Rental",
              viewModel.addCardModel.value.dateOfFirst.toString(), screenSize),
          cartTill(
              "Delivery Option",
              viewModel.addCardModel.value.deliveryOption!.toString(),
              screenSize),
          cartTill(
              "Rental Period",
              viewModel.addCardModel.value.rentalPeriod!.toString(),
              screenSize),
          cartTill("Canopy Type and Size",
              viewModel.addCardModel.value.Canopy!.toString(), screenSize),
        ],
      ));
}

Widget cartTill(String title, String subTitle, Size screenSize) {
  return Padding(
    padding: EdgeInsets.only(bottom: screenSize.height * 0.015),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.bodyMedium),
        Text(subTitle, style: AppTextStyles.bodySubTitle),
      ],
    ),
  );
}

Widget _buildPriceAndQuantityRow(Size screenSize) {
  final quantityController = Get.find<QuantityController>();
  final viewModel = Get.find<RentalViewModel>();
  return Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "US\$${viewModel.cost.value * quantityController.quantity.value}",
            style: AppTextStyles.priceLarge.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          QuantitySelector(
            iconSize: screenSize.width * 0.05,
            textSize: screenSize.width * 0.045,
            buttonSize: screenSize.width * 0.09,
          ),
        ],
      ));
}

Widget _buildProductTitle(Size screenSize) {
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
