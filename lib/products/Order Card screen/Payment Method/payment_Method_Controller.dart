import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Order%20Card%20screen/order%20card%20screen/ordercard_Controller.dart';
import 'package:transwallet/products/Order%20Card%20screen/Review%20order%20Details/review_order_details_Controller.dart';
import 'package:transwallet/products/Wallet%20Screen/Add%20Money/addmoney_Controller.dart';
import 'package:transwallet/products/Send%20money%20screen/send%20money%20process/sendmoneyProcess_Controller.dart';

class PaymentMethodController extends GetxController {
  final RxInt selectedMethod = 1.obs; 
  var walletBalance = 640.obs;
  var amount = 150.obs;

  // Card style details to display on invoice summary
  var cardGradient = <Color>[const Color(0xFF111111), const Color(0xFF2C2C2C)].obs;
  var cardStyleName = "Obsidian Black".obs;
  
  // Delivery details to display on invoice summary
  var deliveryAddress = "General Address".obs;
  var receiverName = "Jane Doe".obs;

  @override
  void onInit() {
    super.onInit();
    // Retrieve values from preceding steps if initialized
    if (Get.isRegistered<OrdercardController>()) {
      final orderCtrl = Get.find<OrdercardController>();
      final activeStyle = orderCtrl.cardStyles[orderCtrl.activeCardIndex.value];
      cardGradient.assignAll(activeStyle["colors"]);
      cardStyleName.value = activeStyle["name"];
      amount.value = orderCtrl.amount.value;
    }
    if (Get.isRegistered<ReviewOrderDetailsController>()) {
      final reviewCtrl = Get.find<ReviewOrderDetailsController>();
      receiverName.value = reviewCtrl.name.value.isEmpty ? "Jane Doe" : reviewCtrl.name.value;
      deliveryAddress.value = reviewCtrl.address1.value.isEmpty
          ? "General Address"
          : "${reviewCtrl.address1.value}, ${reviewCtrl.city.value}, ${reviewCtrl.state.value} - ${reviewCtrl.pincode.value}";
    }
  }

  void processPayment() {
    // Insufficient funds check
    if (selectedMethod.value == 1 && walletBalance.value < amount.value) {
      Get.snackbar(
        "Insufficient Balance",
        "Your wallet has ₹${walletBalance.value}. Please add ₹${amount.value - walletBalance.value} more to proceed.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF111111),
        colorText: Colors.white,
        borderRadius: 16,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    // Trigger MPIN bottom sheet
    Get.bottomSheet(
      MpinVerifySheetForPayment(
        onSuccess: () => _executePayment(),
        title: "Verify MPIN to Order Card",
        subtitle: "Enter MPIN to authorize ₹${amount.value}.00 from General Wallet",
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _executePayment() async {
    // Show visual payment processing loader
    Get.to(() => const PaymentProcessingScreen());

    await Future.delayed(const Duration(seconds: 2));
    
    if (selectedMethod.value == 1) {
      walletBalance.value -= amount.value;
    }

    // Navigate to order details success screen
    Get.offAllNamed('/orderdetails', arguments: {
      'amount': amount.value,
      'cardGradient': cardGradient,
      'cardStyleName': cardStyleName.value,
      'receiverName': receiverName.value,
      'deliveryAddress': deliveryAddress.value,
    });
  }
}