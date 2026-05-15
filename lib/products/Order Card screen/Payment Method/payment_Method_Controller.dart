import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
   final RxInt selectedMethod = 1.obs; var walletBalance = 640.obs;
  var amount = 150.obs;
void processPayment() async {
  await Future.delayed(const Duration(seconds: 2));
  walletBalance.value -= amount.value;
  Get.offAllNamed('/orderdetails');
}
}