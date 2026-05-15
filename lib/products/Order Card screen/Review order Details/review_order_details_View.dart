import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Order%20Card%20screen/Review%20order%20Details/review_order_details_Controller.dart';
import 'package:transwallet/widgets/custombutton.dart';

class ReviewOrderDetailsView extends GetView<ReviewOrderDetailsController> {
  const ReviewOrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ReviewOrderDetailsController(),);
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
                "Review your details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Name
            buildField(
              label: "Name on the card",
              controller:controller. nameController,
              onChanged: (val) => controller.name.value = val,
            ),

            const SizedBox(height: 12),

            // Address Line 1
            buildField(label: "Address Line 1"),

            const SizedBox(height: 12),

            // Address Line 2
            buildField(label: "Address Line 2"),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(child: buildField(label: "Pincode")),
                const SizedBox(width: 10),
                Expanded(child: buildField(label: "City")),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(child: buildField(label: "State")),
                const SizedBox(width: 10),
                Expanded(child: buildField(
                  label: "Country",
                  initialValue: "India",
                  enabled: false,
                )),
              ],
            ),

            const Spacer(),

             CustomButton(text:  "Proceed to pay ₹${controller.amount.value}", btncolor: Colors.black, onPressed: () {
              Get.toNamed('/paymentmethod');
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}