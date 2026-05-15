import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Order%20Card%20screen/order%20card%20screen/ordercard_Controller.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/custombutton.dart';

class OrdercardView extends GetView<OrdercardController> {
  const OrdercardView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OrdercardController());
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
            // Card UI
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Benefits
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Benefits",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("• Affordable"),
                        Text("• Life time free"),
                        Text("• Safe & Secure"),
                      ],
                    ),
                  ),

                  // Amount
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Amount",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => Text(
                            "₹${controller.amount.value}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "*Delivery time will be 5–7 business days.",
                style: TextStyle(color: Colors.grey),
              ),
            ),

            const Spacer(),

          CustomButton(text: "Buy Now", btncolor: Colors.black, onPressed: () {
            Get.toNamed('/revieworderdetails');
          },),
          height24
             
          ],
        ),
      ),
    );
  }
}