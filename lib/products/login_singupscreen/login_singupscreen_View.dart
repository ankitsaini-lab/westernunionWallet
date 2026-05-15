import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/login_singupscreen/login_singupscreen_Controller.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/custombutton.dart';
class LoginSingupscreenView extends GetView<LoginSingupscreenController> {
  const LoginSingupscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginSingupscreenController());
    
     
    const primaryRed = Color(0xFFD64550);
    const darkRed = Color(0xFFB22B37);

    return Scaffold(
  backgroundColor: const Color(0xFFF8F9FA),
  body: SingleChildScrollView(
    child: Column(
      children: [
        const SizedBox(height: 100),

        /// LOGO
        Image.asset(
          "assets/Layer_1.png",
          height: 22,
        ),

        const SizedBox(height: 50),

        /// MAIN CARD
        Obx(
          () => Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: primaryRed.withOpacity(0.06),
                  blurRadius: 40,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Login to Transcorp app to securely access your wallet & make effortless payments.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black45,
                  ),
                ),

                const SizedBox(height: 35),

                /// MOBILE FIELD
                if (!controller.isOtpSent.value)
                  Obx(
                    () => TextField(
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      onChanged: controller.updatePhone,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.phone_android_rounded,
                          color: primaryRed,
                          size: 20,
                        ),

                        prefixText: "+91 ",

                        hintText: "Mobile Number",

                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),

                        /// ERROR TEXT
                        errorText:
                            controller.phoneError.value.isEmpty
                                ? null
                                : controller.phoneError.value,

                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: primaryRed.withOpacity(0.3),
                          ),
                        ),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),

                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                /// TERMS
                if (!controller.isOtpSent.value)
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          activeColor: primaryRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: controller.isChecked.value,
                          onChanged: controller.toggleCheck,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Wrap(
                          children: [
                            const Text(
                              "I agree to ",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),

                            InkWell(
                              onTap: () {},
                              child: const Text(
                                "Terms & Conditions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                /// OTP FIELD
                if (controller.isOtpSent.value)
                  controller.otpField(
                    onCompleted: (otp) {},
                  ),

                const SizedBox(height: 35),

                /// BUTTON
                GestureDetector(
                  onTap: controller.sendOtp,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          primaryRed,
                          darkRed,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),

                      borderRadius: BorderRadius.circular(20),

                      boxShadow: [
                        BoxShadow(
                          color: primaryRed.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        controller.isOtpSent.value
                            ? "VERIFY OTP"
                            : "Send OTP",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),

                /// RESEND SECTION
                if (controller.isOtpSent.value) ...[
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: controller.changeNumber,
                        child: const Text(
                          "Change number",
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      Obx(
                        () => TextButton(
                          onPressed:
                              controller.canResend.value
                                  ? controller.resendOtp
                                  : null,
                          child: Text(
                            controller.canResend.value
                                ? "Resend OTP"
                                : "Resend in ${controller.seconds.value}s",
                            style: TextStyle(
                              color:
                                  controller.canResend.value
                                      ? primaryRed
                                      : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
  }
}
