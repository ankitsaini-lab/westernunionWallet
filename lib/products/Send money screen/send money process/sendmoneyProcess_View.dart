import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Send%20money%20screen/send%20money%20process/sendmoneyProcess_Controller.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/custombutton.dart';

class SendmoneyprocessView extends GetView<SendmoneyprocessController> {
  const SendmoneyprocessView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SendmoneyprocessController());
     return Scaffold(
    backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
         leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Get.back(),
  ),
        title:   Text("Send Money",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500 ,),)
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

           
          Obx(() => Text(
                "Current Balance: ₹${controller.balance.value.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18),
              )),

          const SizedBox(height: 40),

          const Text("Enter amount"),

          const SizedBox(height: 10),

         
          Obx(() => Text(
                "₹${controller.enteredAmount.value.isEmpty ? "0.00" : controller.enteredAmount.value}",
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              )),

          const SizedBox(height: 20),

          /// PRESETS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              controller.presetButton("Custom", 0),
              controller.presetButton("₹200", 200),
              controller.presetButton("₹500", 500),
              controller.presetButton("₹1000", 1000),
            ],
          ),

          const SizedBox(height: 40),

           
          Expanded(
            child: GridView.count(
             crossAxisCount: 3,
  padding: const EdgeInsets.all(15),
  crossAxisSpacing: 15,
  mainAxisSpacing: 15,
  childAspectRatio: 1.5,

             
              children: [
            controller.    keyButton("1"),
             controller.   keyButton("2"),
                controller.keyButton("3"),
                controller.keyButton("4"),
                controller.keyButton("5"),
                controller.keyButton("6"),
                controller.keyButton("7"),
                controller.keyButton("8"),
                controller.keyButton("9"),
                controller.keyButton(","),
                controller.keyButton("0"),
                controller.keyButton("back"),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomButton( 
              isLoading: controller.isLoading.value,
              text: "Send", btncolor: Colors.black, onPressed:() {
                if (controller.amount > 0 && !controller.isLoading.value) {
                  controller.addMoney();
                }
              }, ),
          ),
            height24,
          
        ],
      ),
    );
 
  }
}