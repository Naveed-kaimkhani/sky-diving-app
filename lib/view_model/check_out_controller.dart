import 'package:get/get.dart';
import '../constants/contryCode.dart';

class CheckOutController extends GetxController {
  // Dropdown Selections
  Rx<CountryCallingCode?> countryCallingCode = Rx<CountryCallingCode?>(null);
  Rx<Country?> countryName = Rx<Country?>(null);
  Rx<StateAbbreviation?> stateAbbreviation = Rx<StateAbbreviation?>(null);

  // Lists
  List<Country> countryModels = countryNames.map((name) => Country(name: name)).toList();
  List<CountryCallingCode> countryCallingCodeList =
  countryCallingCodes.map((map) => CountryCallingCode.fromMap(map)).toList();
  List<StateAbbreviation> stateModels =
  usStateAbbreviations.map((abbr) => StateAbbreviation(abbreviation: abbr)).toList();

  // User inputs
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var addressLine1 = ''.obs;
  var addressLine2 = ''.obs;
  var city = ''.obs;
  var zipCode = ''.obs;
  var cardNumber = ''.obs;
  var cardExpiry = ''.obs;
  var cvv = ''.obs;
  var cashAppText = ''.obs;

  // Validation function
  bool validateFields() {
    if (firstName.value.isEmpty) {
      Get.snackbar("Error", "Please enter first name");
      return false;
    }
    if (lastName.value.isEmpty) {
      Get.snackbar("Error", "Please enter last name");
      return false;
    }
    if (email.value.isEmpty) {
      Get.snackbar("Error", "Please enter email");
      return false;
    }
    if (phoneNumber.value.isEmpty) {
      Get.snackbar("Error", "Please enter phone number");
      return false;
    }
    if (addressLine1.value.isEmpty) {
      Get.snackbar("Error", "Please enter address line 1");
      return false;
    }
    if (city.value.isEmpty) {
      Get.snackbar("Error", "Please enter city");
      return false;
    }
    if (cashAppText.value.isEmpty) {
      Get.snackbar("Error", "Please enter Cash App Pay");
      return false;
    }
    if (zipCode.value.isEmpty) {
      Get.snackbar("Error", "Please enter zip code");
      return false;
    }
    if (cardNumber.value.isEmpty) {
      Get.snackbar("Error", "Please enter card number");
      return false;
    }
    if (cardExpiry.value.isEmpty) {
      Get.snackbar("Error", "Please enter card expiry date");
      return false;
    }
    if (cvv.value.isEmpty) {
      Get.snackbar("Error", "Please enter CVV");
      return false;
    }
    return true;
  }
}



// import 'package:get/get.dart';
//
// import '../constants/contryCode.dart';
//
// class CheckOutController extends GetxController{
//
//   Rx<CountryCallingCode> countryCallingCode = CountryCallingCode().obs;
//   Rx<Country> countryName = Country().obs;
//   Rx<StateAbbreviation> stateAbbreviation = StateAbbreviation().obs;
//
//   List<Country> countryModels = countryNames.map((name) => Country(name: name)).toList();
//   final List<CountryCallingCode> countryCallingCodeList = countryCallingCodes
//       .map((map) => CountryCallingCode.fromMap(map))
//       .toList();
//   List<StateAbbreviation> stateModels = usStateAbbreviations
//       .map((abbr) => StateAbbreviation(abbreviation: abbr))
//       .toList();
//
// }