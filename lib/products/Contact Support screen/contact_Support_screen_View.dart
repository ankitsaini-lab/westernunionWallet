import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Contact%20Support%20screen/contact_Support_screen_Controller.dart';

class ContactSupportScreenView extends GetView<ContactSupportScreenController> {
  const ContactSupportScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ContactSupportScreenController(),); 
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Contact Support Screen"),
            ],
          ),
        ),
    );
  }
}