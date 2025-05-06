import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:square_in_app_payments/in_app_payments.dart';
// import 'package:square_in_app_payments/models.dart';
import '../../components/app_text_styles.dart';
import '../../components/auth_button.dart';
import '../../components/custom_textfield.dart';
import '../../components/title_appbar.dart';
import '../../constants/custom_drop_down.dart';
import '../../constants/contryCode.dart';
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
          if (controller.validateFields()) {
          } else {}
          // Get.toNamed(RouteName.checkOut);
          // Handle add to cart
        },
      ),
    );
  }

  // Future<void> startCardPaymentFlow() async {
  //   try {
  //     await InAppPayments.startCardEntryFlow(
  //       onCardNonceRequestSuccess: (CardDetails result) async {
  //         // ✅ Print nonce (safe for development)
  //         print('🔐 Card nonce: ${result.nonce}');

  //         // 🔁 Simulate sending nonce to backend
  //         // final isSuccess = await _sendNonceToBackend(result.nonce);

  //         if (true) {
  //           // ✅ Close UI after success
  //           InAppPayments.completeCardEntry(
  //             onCardEntryComplete: () {
  //               print('✅ Payment completed successfully.');
  //             },
  //           );
  //         } else {
  //           // ❌ Show error in UI
  //           InAppPayments.showCardNonceProcessingError(
  //               "Payment failed. Please try again.");
  //         }
  //       },
  //       onCardEntryCancel: () {
  //         print('❌ Payment cancelled by user.');
  //       },
  //     );
  //   } catch (ex) {
  //     print('⚠️ Error during card entry: $ex');
  //   }
  // }

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
                  keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
                hintText: "Card Number",
                iconData: Icons.credit_card,
                onChanged: (val) => controller.cardNumber.value = val,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
                      hintText: "MM/YY",
                      onChanged: (val) => controller.cardExpiry.value = val,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
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
