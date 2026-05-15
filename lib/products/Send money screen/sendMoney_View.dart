import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Send%20money%20screen/sendMoney_Controller.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/custombutton.dart';

class SendmoneyView extends GetView<SendmoneyController> {
  const SendmoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SendmoneyController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        
         backgroundColor: Colors.white,
        leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Get.back(),
  ),
        title: Text("Send Money", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18), ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Text("Choose the transfer type"),

            // SizedBox(height: 12),

            // Obx(
            //   () =>  Row(
            //     children: [
            //       Expanded(
            //         child: GestureDetector(
            //           onTap: () {
            //             controller.istransferTypeP2P.value = true;
            //           },
            //           child: controller.tab("P2P Transfer",controller. istransferTypeP2P.value)),
            //       ),
            //       SizedBox(width: 10),
            //       Expanded(
            //         child: GestureDetector(
            //           onTap: () {
            //             controller.istransferTypeP2P.value = false;
            //           },
            //           child: controller.tab("Bank Transfer", controller. istransferTypeP2P.value== false)),
            //       ),
            //     ],
            //   ),
            // ),

            // SizedBox(height: 20),

         Obx(() => controller.istransferTypeP2P.value
    ? Column(
        children: [
          TextField(
            keyboardType: TextInputType.phone,
            controller: controller.phoneController,
            onChanged: controller.updateNumber,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  controller.selectedCountryCode.value,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              hintText: "Enter mobile number",
              suffixIcon: IconButton(
                icon: const Icon(Icons.contacts),
                onPressed: () => Get.to(() => ContactPage()),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
 

          
         
        ],
      )
    : const SizedBox()),
Obx(() => controller.istransferTypeP2P.value != true ? SizedBox() : Spacer()),
           Obx(
            () => controller.istransferTypeP2P.value != true ? SizedBox() :  CustomButton(
              text: "Proceed",
              btncolor: controller.isValid.value
                  ? Colors.black
                  : Colors.grey,
              onPressed: () {
                if (controller.isValid.value) {
                  Get.toNamed("/sendmoneyprocess");
                }
              },
                       ),
           ),
         Obx(() =>  controller.istransferTypeP2P.value  == true ?Container() : controller.buildStep()),

            height32
          ],
        ),
      ),
    );
  }
}