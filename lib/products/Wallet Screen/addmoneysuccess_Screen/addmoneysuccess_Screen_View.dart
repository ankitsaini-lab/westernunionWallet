import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:transwallet/products/Wallet%20Screen/addmoneysuccess_Screen/addmoneysuccess_Screen_Controller.dart';

class AddmoneysuccessScreenView extends GetView<AddmoneysuccessScreenController> {
  const AddmoneysuccessScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddmoneysuccessScreenController(),);
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Add Money Success Screen"),
            ],
          ),
        ),
    );
  }
}