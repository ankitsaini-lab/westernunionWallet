import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/minKYCScreen/minkycScreen_Controller.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/custombutton.dart';
import 'package:transwallet/widgets/upercasetextformatter.dart';

class MinkycscreenView extends GetView<MinkycscreenController> {
  const MinkycscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MinkycscreenController(),);
   return Scaffold(
   appBar: AppBar(
     
  title: const Text(
    "Min KYC",
    style: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  centerTitle: false,  
  backgroundColor: Colors.white,
  elevation: 0,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Get.back(),
  ),
),
backgroundColor: Colors.white,
  body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const SizedBox(height: 30),

      /// 🔥 TITLE
      const Text(
        "Verify PAN",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Color(0xFF111111),
        ),
      ),

      const SizedBox(height: 8),

      const Text(
        "Complete your KYC to activate your wallet",
        style: TextStyle(color: Colors.grey),
      ),

      const SizedBox(height: 30),

      /// 🔥 INPUT (Premium)
      TextField(
        onChanged: controller.onPanChanged,
        style: const TextStyle(letterSpacing: 2),
        inputFormatters: [
    LengthLimitingTextInputFormatter(10), 
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),  
    UpperCaseTextFormatter(),  
  ],
        decoration: InputDecoration(
          hintText: "ABCDE1234F",
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFE53935),
              width: 1.2,
            ),
          ),
        ),
      ),

      const SizedBox(height: 12),

      const Text(
        "* OTP will be sent to your registered mobile",
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),

      const Spacer(),

      /// 🔥 BUTTON (already premium)
      Obx(() => CustomButton(
            text: "Continue",
            btncolor: const Color(0xFF111111),
            onPressed: controller.isButtonEnabled.value
                ? () => controller.showOtpBottomSheet(context)
                : () {},
          )),

      const SizedBox(height: 20),
    ],
  ),
),  );
  }
}