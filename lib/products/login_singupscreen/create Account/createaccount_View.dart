import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/login_singupscreen/create%20Account/createaccount_Controller.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/custombutton.dart';

class CreateaccountView extends GetView<CreateaccountController> {
  const CreateaccountView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateaccountController());

    const primaryRed = Color(0xFFFFCC00);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),

                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 800),
                  tween: Tween<double>(begin: 30.0, end: 0.0),
                  curve: Curves.easeOutQuart,
                  builder: (context, double value, child) {
                    return Transform.translate(
                      offset: Offset(0, value),
                      child: Opacity(
                        opacity: (1 - (value / 30)).clamp(0.0, 1.0),
                        child: child,
                      ),
                    );
                  },
                  child: Image.asset("assets/Wuu.png", height: 38),
                ),

                const SizedBox(height: 30),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: primaryRed.withOpacity(0.05),
                        blurRadius: 40,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111111),
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Step into simpler payments",
                        style: TextStyle(color: Colors.black38, fontSize: 12),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        children: [
                          Expanded(child: controller.buildStep("Details", 1)),
                          const SizedBox(width: 12),
                          Expanded(child: controller.buildStep("Address", 2)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Obx(
                        () => AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          switchInCurve: Curves.easeIn,
                          switchOutCurve: Curves.easeOut,
                          child: controller.step.value == 1
                              ? controller.buildStepOene(context)
                              : controller.buildStepTwo(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
