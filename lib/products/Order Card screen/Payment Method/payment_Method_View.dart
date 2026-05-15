import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Order%20Card%20screen/Payment%20Method/payment_Method_Controller.dart';
import 'package:transwallet/products/Send%20money%20screen/send%20money%20process/sendmoneyProcess_Controller.dart';
import 'package:transwallet/products/Wallet%20Screen/Add%20Money/addmoney_Controller.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/custombutton.dart';

class PaymentMethodView extends GetView<PaymentMethodController> {
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PaymentMethodController(),);
     return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
          leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Get.back(),
  ),
        title:   Text("Order Card",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500 ,fontSize: 18),),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select payment method",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Wallet Option
            Obx(() => Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: controller. selectedMethod.value == 1
                          ? Colors.black
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Radio<int>(
                        value: 1,
                        groupValue: controller. selectedMethod.value,
                        onChanged: (val) {
                         controller. selectedMethod.value = val!;
                        },
                      ),
                      const Text("General Wallet"),

                      const Spacer(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(() => Text(
                                "₹${controller.walletBalance.value}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          GestureDetector(
                            onTap: () {
                              // Mock add money
                              controller.walletBalance.value += 500;

                              Get.snackbar(
                                "Success",
                                "₹500 added to wallet",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            child: const Text(
                              "Add Money",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),

            const SizedBox(height: 12),

            // Other Payment Option
            // Obx(() => 
            Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: controller. selectedMethod.value == 2
                          ? Colors.black
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Radio<int>(
                        value: 2,
                        groupValue: controller. selectedMethod.value,
                        onChanged: (val) {
                         controller. selectedMethod.value = val!;
                        },
                      ),
                      const Text("Other payment options"),
                    ],
                  ),
                ),
                // ),

            const Spacer(),

          CustomButton(text: "Pay Now", btncolor: Colors.black, onPressed: () {
            Get.to(() => PaymentProcessingScreen());
            controller.processPayment();
          }),

          height24
           ],
        ),
      ),
    );
  }
}