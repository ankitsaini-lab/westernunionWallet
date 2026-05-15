import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/update_KYC/update_KYC_controller.dart';

class UpdateKycView extends GetView<UpdateKycController> {
  const UpdateKycView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UpdateKycController(),);
     return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar(
       leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Get.back(),
  ),
      backgroundColor: Colors.white,
  centerTitle: false,
  titleSpacing: 0,
  title: Obx(() => Text(
        controller.isFullKycStarted.value
            ? "Full KYC"
            : "Update KYC",
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
      )),
),
      body: Obx(() {
        return controller.isFullKycStarted.value
            ? controller.fullKycView()
            : controller.updateKycView();
      }),
    );
  }
}