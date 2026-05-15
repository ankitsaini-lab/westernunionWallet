import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Onboarding%20Screen/onboardingscreen_controller.dart';

class OnboardingscreenView extends GetView<OnboardingscreenController> {
  const OnboardingscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OnboardingscreenController(),);
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Onboarding Screen"),
            ],
          ),
        ),
    );
  }
}