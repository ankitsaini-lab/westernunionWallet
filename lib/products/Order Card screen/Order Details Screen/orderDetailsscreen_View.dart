import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Order%20Card%20screen/Order%20Details%20Screen/orderDetailsscreen_Controller.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/custombutton.dart';

class OrderdetailsscreenView extends GetView<OrderdetailsscreenController> {
  const OrderdetailsscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OrderdetailsscreenController(),);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
          leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Get.back(),
  ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ✅ Icon
            const Icon(Icons.verified, color: Colors.green, size: 60),

            const SizedBox(height: 10),

            const Text(
              "Transcorp card ordered!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Delivery Info
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      "Your card should arrive by\nThursday 12 Dec, 2024.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Icon(Icons.local_shipping, color: Colors.blue),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Order Details Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Divider(),

                 controller. row("Address Line 1", "Flat A-104"),
                  controller.row("Address Line 2", "4th Main Road"),
                  controller.row("City", "Bengaluru"),
                  controller.row("State", "Karnataka"),
                  controller.row("Country", "India"),

                  const SizedBox(height: 10),

                  Obx(() => controller.row(
                        "Amount Paid",
                        "₹${controller.amount.value}",
                        isBold: true,
                      )),
                ],
              ),
            ),

            const Spacer(),

           CustomButton(text: "Back to Home", btncolor: Colors.black, onPressed: () {
              Get.offAllNamed('/dashboard');
            }),
            height32
          ],
        ),
      ),
    );
  }
}