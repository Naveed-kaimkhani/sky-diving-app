import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/app_text_styles.dart';
import '../../components/auth_button.dart';
import '../../components/custom_textfield.dart';
import '../../components/title_appbar.dart';
import '../../constants/custom_drop_down.dart';
import '../../constants/contryCode.dart';
import '../../constants/routes_name.dart';
import '../../view_model/check_out_controller.dart';

class CheckOut extends StatelessWidget {
  final CheckOutController controller = Get.put(CheckOutController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TitleAppBar(
        onBackPressed: () => Get.back(),
        title: "Checkout",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
        child: Column(
          children: [
            contactSection(),
            addressSection(),
            paymentSection(),
            cashAppSection(),
            orderSummarySection(),
            _buildAddToCartButton()
          ],
        ),
      ),
    );
  }
  Widget _buildAddToCartButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: AuthButton(
        buttonText: "Continue Payment",
        isLoading: false.obs,
        onPressed: () {
          if(controller.validateFields()){


          }else{

          }
          // Get.toNamed(RouteName.checkOut);
          // Handle add to cart
        },
      ),
    );
  }
  Widget contactSection() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Contact"),
            CustomDropdown<CountryCallingCode>(
              selectedItem: controller.countryCallingCode.value,
              onChanged: (value) => controller.countryCallingCode.value = value,
              items: controller.countryCallingCodeList,
            ),
            gap(),
            CustomTextField(
              hintText: "Phone Number",
              onChanged: (val) => controller.phoneNumber.value = val,
            ),
            gap(),
            CustomTextField(
              hintText: "Email Address for receipt",
              onChanged: (val) => controller.email.value = val,
            ),
            gap(),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: "First Name",
                    onChanged: (val) => controller.firstName.value = val,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    hintText: "Last Name",
                    onChanged: (val) => controller.lastName.value = val,
                  ),
                ),
              ],
            ),
            gap(20),
          ],
        ));
  }

  Widget addressSection() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Address"),
            CustomDropdown<Country>(
              selectedItem: controller.countryName.value,
              onChanged: (value) => controller.countryName.value = value,
              items: controller.countryModels,
            ),
            gap(),
            CustomTextField(
              hintText: "Enter Your Address here",
              onChanged: (val) => controller.addressLine1.value = val,
            ),
            gap(),
            CustomTextField(
              hintText: "Apt, Suite, Floor, etc",
              onChanged: (val) => controller.addressLine2.value = val,
            ),
            gap(),
            CustomTextField(
              hintText: "City",
              onChanged: (val) => controller.city.value = val,
            ),
            gap(),
            Row(
              children: [
                Expanded(
                  child: CustomDropdown<StateAbbreviation>(
                    selectedItem: controller.stateAbbreviation.value,
                    onChanged: (value) =>
                        controller.stateAbbreviation.value = value,
                    items: controller.stateModels,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: CustomTextField(
                      keyboardType:TextInputType.number,
                  hintText: "ZIP Code",
                  onChanged: (val) => controller.zipCode.value = val,
                )),
              ],
            ),
            gap(20),
          ],
        ));
  }

  Widget paymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle("Payment"),
        Container(
          padding: EdgeInsets.all(16),
          decoration: decoratedBox(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle("Credit Card"),
              gap(),
              CustomTextField(
                keyboardType:TextInputType.number,
                hintText: "Card Number",
                iconData: Icons.credit_card,
                onChanged: (val) => controller.cardNumber.value = val,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      keyboardType:TextInputType.number,
                      hintText: "MM/YY",
                      onChanged: (val) => controller.cardExpiry.value = val,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      keyboardType:TextInputType.number,
                      hintText: "CVV",
                      onChanged: (val) => controller.cvv.value = val,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        gap(20),
      ],
    );
  }

  Widget gap([double height = 16]) => SizedBox(height: height);

  Widget cashAppSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle("Cash App Pay"),
        CustomTextField(
          iconData: Icons.calendar_view_day_sharp,
          hintText: "Cash App Pay",
          onChanged: (val) => controller.cashAppText.value = val,
        ),
        gap(20),
      ],
    );
  }

  Widget orderSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle("Order Summary (6 items)"),
        Container(
          padding: EdgeInsets.all(16),
          decoration: decoratedBox(),
          child: Column(
            children: [
              orderRow("Subtotal", "\$${70.00 * 6}"),
              orderRow("Estimated Taxes", "\$20.00"),
              orderRow("Skydiving Gear Rental", "\$70.00"),
              orderRow("Estimated Total", "\$510.00"),
            ],
          ),
        ),
        gap(30),
      ],
    );
  }

  Widget orderRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.bodyMedium),
          Text(value, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }

  Widget sectionTitle(String text) => Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(text,
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.white)));

  // EdgeInsets gap([double height = 16]) => EdgeInsets.only(top: height);

  BoxDecoration decoratedBox() => BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      );
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../components/app_text_styles.dart';
// import '../../components/custom_textfield.dart';
// import '../../components/title_appbar.dart';
// import '../../constants/contryCode.dart';
// import '../../constants/custom_drop_down.dart';
// import '../../view_model/check_out_controller.dart';
//
// class CheckOut extends StatefulWidget {
//   const CheckOut({super.key});
//
//   @override
//   State<CheckOut> createState() => _CheckOutState();
// }
//
// class _CheckOutState extends State<CheckOut> {
//   final CheckOutController checkOutController = Get.put(CheckOutController());
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: TitleAppBar(
//         onBackPressed: () => Get.back(),
//         title: "Checkout",
//       ),
//       body: _buildBody(screenSize),
//     );
//   }
// }
//
// Widget _buildBody(Size screenSize) {
//   return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: screenSize.width * 0.05,
//         // vertical: screenSize.height * 0.01,
//       ),
//       child: SingleChildScrollView(
//           child: Column(
//         children: [
//           contact(),
//           address(),
//           cardDesign(),
//           cashApp(),
//           orderSummry()
//         ],
//       )));
// }
//
// Widget orderSummry() {
//   return
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//       SizedBox(
//         height: 20,
//       ),
//       Text(
//         "PaymentOrder Summary (6 items)",style: AppTextStyles.bodyMedium,
//       ),
//       SizedBox(
//         height: 8,
//       ),
//       Container(
//         padding: EdgeInsets.all(16),
//         // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//         decoration: BoxDecoration(
//           // color: Colors.white,
//           border: Border.all(
//             color: Colors.grey.shade300,
//             width: 1,
//           ),
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: 15),
//             calculatedCartTill("Subtotal", "\$${70.00 * 70}"),
//             calculatedCartTill("Estimated taxes", "\$70.00"),
//             calculatedCartTill(
//               "Estimated order total",
//               "\$70.00",
//             ),
//             calculatedCartTill(
//               "Skydiving Gear Rental",
//               "\$70.00",
//             ),
//
//           ],
//         ),
//
//       ),
//         SizedBox(
//           height: 20,
//         ),
//       // CustomTextField(
//       //     hintText: "Add Coupon or gift card",
//       //     onChanged: (val) {
//       //       // viewModel.addCardModel.update((model) {
//       //       //   model?.dateOfFirst = val.toString();
//       //       // });
//       //     }),
//     ],)
//     ;
// }
//
// Widget calculatedCartTill(
//   String title,
//   String subTitle,
// ) {
//   return Padding(
//     padding: EdgeInsets.only(bottom: 8),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       // crossAxisAlignment: CrossAxisAlignment.s,
//       children: [
//         Text(title!, style: AppTextStyles.bodyMedium),
//         Text(subTitle!, style: AppTextStyles.bodyMedium),
//       ],
//     ),
//   );
// }
//
// Widget cashApp() {
//   return Column(
//     children: [
//       SizedBox(
//         height: 20,
//       ),
//       CustomTextField(
//           iconData: Icons.calendar_view_day_sharp,
//           hintText: "Cash App Pay",
//           onChanged: (val) {
//             // viewModel.addCardModel.update((model) {
//             //   model?.dateOfFirst = val.toString();
//             // });
//           })
//     ],
//   );
// }
//
// Widget cardDesign() {
//   final CheckOutController checkOutController = Get.find();
//
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       SizedBox(
//         height: 8,
//       ),
//       Text(
//         "Payment",
//         style: AppTextStyles.bodyMedium,
//       ),
//       SizedBox(
//         height: 8,
//       ),
//       Container(
//         padding: EdgeInsets.all(16),
//         // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//         decoration: BoxDecoration(
//           // color: Colors.white,
//           border: Border.all(
//             color: Colors.grey.shade300,
//             width: 1,
//           ),
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // SizedBox(height:),
//             Text(
//               "Credit Card",
//               style: AppTextStyles.bodyMedium,
//             ),
//             SizedBox(height: 8),
//             CustomDropdown<Country>(
//               selectedItem: checkOutController.countryName.value,
//               onChanged: (value) {
//                 checkOutController.countryName.value = value!;
//               },
//               items: checkOutController.countryModels,
//             ),
//             SizedBox(height: 20),
//             CustomTextField(
//                 hintText: "Card Number",
//                 iconData: Icons.credit_card,
//                 onChanged: (val) {
//                   // viewModel.addCardModel.update((model) {
//                   //   model?.dateOfFirst = val.toString();
//                   // });
//                 }),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextField(
//                       hintText: "MM/Y",
//                       onChanged: (val) {
//                         // viewModel.addCardModel.update((model) {
//                         //   model?.dateOfFirst = val.toString();
//                         // });
//                       }),
//                 ),
//                 Expanded(
//                   child: CustomTextField(
//                       hintText: "CVV",
//                       onChanged: (val) {
//                         // viewModel.addCardModel.update((model) {
//                         //   model?.dateOfFirst = val.toString();
//                         // });
//                       }),
//                 ),
//               ],
//             )
//           ],
//         ),
//       )
//     ],
//   );
// }
//
// Widget contact() {
//   final CheckOutController checkOutController = Get.find();
//   return Obx(() => Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Contact",
//             style: AppTextStyles.bodyMedium,
//           ),
//           SizedBox(
//             height: 8,
//           ),
//           CustomDropdown<CountryCallingCode>(
//             selectedItem: checkOutController.countryCallingCode.value,
//             onChanged: (value) {
//               checkOutController.countryCallingCode.value = value!;
//             },
//             items: checkOutController.countryCallingCodeList,
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           CustomTextField(
//               hintText: "Phone Number",
//               onChanged: (val) {
//                 // viewModel.addCardModel.update((model) {
//                 //   model?.dateOfFirst = val.toString();
//                 // });
//               }),
//           SizedBox(
//             height: 16,
//           ),
//           CustomTextField(
//               hintText: "Email Address for receipt",
//               onChanged: (val) {
//                 // viewModel.addCardModel.update((model) {
//                 //   model?.dateOfFirst = val.toString();
//                 // });
//               }),
//           SizedBox(
//             height: 16,
//           ),
//           Row(children: [
//
//             Expanded(child: CustomTextField(
//                 hintText: "First Name",
//                 onChanged: (val) {
//                   // viewModel.addCardModel.update((model) {
//                   //   model?.dateOfFirst = val.toString();
//                   // });
//                 }),),
//             SizedBox(
//               width: 16,
//             ),
//             Expanded(child: CustomTextField(
//                 hintText: "Last Name",
//                 onChanged: (val) {
//                   // viewModel.addCardModel.update((model) {
//                   //   model?.dateOfFirst = val.toString();
//                   // });
//                 }),)
//
//
//           ],),
//           // Text(
//           // "By providing your phone number/email, you agree to receive order updates via text or email from Square and our other partners on our behalf. Learn more "
//           // 'Reply STOP to opt-out of receiving future text messages related to your order, and HELP for help. Standard message and data rates may apply. Message frequency may vary. '
//           //     'You can unsubscribe from any email sent to you.', style: TextStyle(color: Colors.white,fontSize: 10),)
//           SizedBox(
//             height: 20,
//           ),
//         ],
//       ));
// }
//
// Widget address() {
//   final CheckOutController checkOutController = Get.find();
//   return Obx(() => Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Address",
//             style: AppTextStyles.bodyMedium,
//           ),
//           SizedBox(
//             height: 8,
//           ),
//           CustomDropdown<Country>(
//             selectedItem: checkOutController.countryName.value,
//             onChanged: (value) {
//               checkOutController.countryName.value = value!;
//             },
//             items: checkOutController.countryModels,
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           CustomTextField(
//               hintText: "Enter Your Address here",
//               onChanged: (val) {
//                 // viewModel.addCardModel.update((model) {
//                 //   model?.dateOfFirst = val.toString();
//                 // });
//               }),
//           SizedBox(
//             height: 16,
//           ),
//
//           SizedBox(
//             height: 16,
//           ),
//           CustomTextField(
//               hintText: "Apt, Suite, Floor, etc",
//               onChanged: (val) {
//                 // viewModel.addCardModel.update((model) {
//                 //   model?.dateOfFirst = val.toString();
//                 // });
//               }),
//           SizedBox(
//             height: 16,
//           ),
//           CustomTextField(
//               hintText: "City",
//               onChanged: (val) {
//                 // viewModel.addCardModel.update((model) {
//                 //   model?.dateOfFirst = val.toString();
//                 // });
//               }),
//           SizedBox(
//             height: 16,
//           ),
//         Row(children: [
//           Expanded(child:
//           CustomDropdown<StateAbbreviation>(
//             selectedItem: checkOutController.stateAbbreviation.value,
//             onChanged: (value) {
//               checkOutController.stateAbbreviation.value = value!;
//             },
//             items: checkOutController.stateModels,
//           )),
//           SizedBox(
//             width: 16,
//           ),
//          Expanded(child:  CustomTextField(
//              hintText: "Postal code",
//              onChanged: (val) {
//                // viewModel.addCardModel.update((model) {
//                //   model?.dateOfFirst = val.toString();
//                // });
//              })),
//
//         ],)
//           // Text(
//           // "By providing your phone number/email, you agree to receive order updates via text or email from Square and our other partners on our behalf. Learn more "
//           // 'Reply STOP to opt-out of receiving future text messages related to your order, and HELP for help. Standard message and data rates may apply. Message frequency may vary. '
//           //     'You can unsubscribe from any email sent to you.', style: TextStyle(color: Colors.white,fontSize: 10),)
//         ],
//       ));
// }
