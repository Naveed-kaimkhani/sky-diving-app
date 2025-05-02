import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/app_text_styles.dart';
import '../../components/auth_button.dart';
import '../../components/quantity_selector.dart';
import '../../components/title_appbar.dart';
import '../../constants/app_colors.dart';
import '../../view_model/rental_view_model.dart';
import 'add_item_conrtroller.dart';

class AddOrderCard extends StatefulWidget {
  const AddOrderCard({super.key});

  @override
  State<AddOrderCard> createState() => _AddOrderCardState();
}

class _AddOrderCardState extends State<AddOrderCard> {
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
        // Get.toNamed(RouteName.addOrderCard);
        // Handle add to cart
      },
    ),
  );
}
Widget _buildBody(Size screenSize) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: screenSize.width * 0.05,
      vertical: screenSize.height * 0.02,
    ),
    child:SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  _buildProductImage(screenSize),
  SizedBox(
  height: 10,
  ),
  _buildProductTitle(screenSize),
    _buildPriceAndQuantityRow(screenSize),
    SizedBox(height: 30,),
    buildSelectorValue(screenSize),
    _buildAddToCartButton()
  ])));
}
Widget buildSelectorValue( Size screenSize){
  final viewModel = Get.find<RentalViewModel>();
  viewModel.cardOnj();
  return Obx(()=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    cartTill("Skydiving Gear Rental", "\$70.00", screenSize),
              cartTill("Date of First Day of Rental", viewModel.addCardModel.value.dateOfFirst!, screenSize),
              cartTill("Delivery Option", viewModel.addCardModel.value.deliveryDesSub!, screenSize),
              cartTill("Rental Period", viewModel.addCardModel.value.rentalPeriod!, screenSize),
              cartTill("Canopy Type and Size", viewModel.addCardModel.value.Canopy!, screenSize),
  ],));
}
Widget cartTill(String title, String subTitle, Size screenSize) {
  return Padding(
    padding: EdgeInsets.only(bottom: screenSize.height * 0.015),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!, style: AppTextStyles.bodyMedium),
        Text(subTitle!, style: AppTextStyles.bodySubTitle),
      ],
    ),
  );
}
Widget _buildPriceAndQuantityRow(Size screenSize) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "US\$70.00",
        style:
        AppTextStyles.priceLarge.copyWith(color: AppColors.primaryColor),
      ),
      QuantitySelector(
        iconSize: screenSize.width * 0.05,
        textSize: screenSize.width * 0.045,
        buttonSize: screenSize.width * 0.09,
      ),
    ],
  );
}
Widget _buildProductTitle( Size screenSize) {
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
// Widget card(int index, Size screenSize) {
//   final tag = 'card_$index';
//   if (!Get.isRegistered<AddCardController>(tag: tag)) {
//     Get.put(AddCardController(), tag: tag);
//   }
//   final controller = Get.find<AddCardController>(tag: tag);
//
//   return Container(
//     margin: EdgeInsets.only(bottom: screenSize.height * 0.03),
//     padding: const EdgeInsets.all(12),
//     decoration: BoxDecoration(
//       color: Colors.white.withOpacity(0.05),
//       borderRadius: BorderRadius.circular(12),
//       border: Border.all(color: Colors.white10),
//     ),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 100,
//           height: 100,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/png/bag1.png"),
//               fit: BoxFit.cover,
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//         ),
//         SizedBox(width: screenSize.width * 0.05),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               cartTill("Skydiving Gear Rental", "\$70.00", screenSize),
//               cartTill("Date of First Day of Rental", "May 5, 2025", screenSize),
//               cartTill("Delivery Option", "Pickup at Longmont", screenSize),
//               cartTill("Rental Period", "30 Days (US\$530.00)", screenSize),
//               cartTill("Canopy Type and Size", "Spector 170", screenSize),
//               IncDecButton(controller, screenSize),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget cartTill(String title, String subTitle, Size screenSize) {
//   return Padding(
//     padding: EdgeInsets.only(bottom: screenSize.height * 0.015),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: AppTextStyles.bodySmall),
//         Text(subTitle, style: AppTextStyles.bodySubTitle),
//       ],
//     ),
//   );
// }
//
// Widget IncDecButton(AddCardController controller, Size screenSize) {
//   return Row(
//     children: [
//       _circleButton(Icons.remove, controller.decrement),
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
//         child: Obx(() => Text(
//           controller.itemCount.value.toString(),
//           style: const TextStyle(color: Colors.white, fontSize: 18),
//         )),
//       ),
//       _circleButton(Icons.add, controller.increment),
//     ],
//   );
// }
//
// Widget _circleButton(IconData icon, VoidCallback onPressed) {
//   return CircleAvatar(
//     backgroundColor: Colors.grey,
//     child: IconButton(
//       icon: Icon(icon, color: Colors.white),
//       onPressed: onPressed,
//     ),
//   );
// }
