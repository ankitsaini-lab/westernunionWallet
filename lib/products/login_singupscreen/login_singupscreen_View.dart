import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:transwallet/products/login_singupscreen/login_singupscreen_Controller.dart';

class LoginSingupscreenView extends GetView<LoginSingupscreenController> {
  const LoginSingupscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginSingupscreenController());

    const primaryRed = Color(0xFFD64550);
    const darkRed = Color(0xFFB22B37);

    return Scaffold(
      // backgroundColor: Colors.black, // Dark canvas for seamless loading
      body: Stack(
        children: [
          Obx(() {
            if (controller.isVideoInitialized.value) {
              return SizedBox.expand(
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: controller.videoController.value.size.width,
                          height: controller.videoController.value.size.height,
                          child: VideoPlayer(controller.videoController),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(color: Colors.black);
            }
          }),

          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 60),

                    Image.asset("assets/WHITE TRANSCORP .png", height: 24),

                    const SizedBox(height: 40),

                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 26,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.86),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.18),
                                    blurRadius: 30,
                                    offset: const Offset(0, 15),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Obx(() {
                                    if (controller.isOtpSent.value) {
                                      return Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: primaryRed.withOpacity(
                                                0.08,
                                              ),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: primaryRed.withOpacity(
                                                  0.25,
                                                ),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.mark_email_read_rounded,
                                              color: primaryRed,
                                              size: 32,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  }),
                                  Obx(
                                    () => Text(
                                      controller.isOtpSent.value
                                          ? "Verify Code"
                                          : "Welcome",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: -0.5,
                                        color: Color(0xFF111111),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Obx(
                                    () => Text(
                                      controller.isOtpSent.value
                                          ? "Enter the 4-digit code sent to +91 ******${controller.phone.value.length >= 4 ? controller.phone.value.substring(controller.phone.value.length - 4) : controller.phone.value}"
                                          : "Login to Transcorp app to securely access your wallet & make effortless payments.",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  if (!controller.isOtpSent.value)
                                    Obx(() {
                                      final bool hasError = controller
                                          .phoneError
                                          .value
                                          .isNotEmpty;
                                      final bool isFocused =
                                          controller.isPhoneFocused.value;

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 200,
                                            ),
                                            curve: Curves.easeOutCubic,
                                            decoration: BoxDecoration(
                                              color: isFocused
                                                  ? Colors.white
                                                  : const Color(0xFFF5F6F8),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: hasError
                                                    ? Colors.red
                                                    : (isFocused
                                                          ? primaryRed
                                                          : const Color(
                                                              0xFFE5E7EB,
                                                            )),
                                                width: isFocused ? 2.0 : 1.5,
                                              ),
                                              boxShadow: isFocused
                                                  ? [
                                                      BoxShadow(
                                                        color: primaryRed
                                                            .withOpacity(0.08),
                                                        blurRadius: 12,
                                                        offset: const Offset(
                                                          0,
                                                          4,
                                                        ),
                                                      ),
                                                    ]
                                                  : [],
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 18,
                                                        right: 12,
                                                      ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Text(
                                                        "🇮🇳",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        "+91",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: Colors.black
                                                              .withOpacity(0.8),
                                                          fontSize: 15.5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 1.5,
                                                  height: 24,
                                                  color: const Color(
                                                    0xFFE5E7EB,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                    controller: controller
                                                        .phoneController,
                                                    focusNode: controller
                                                        .phoneFocusNode,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    onChanged:
                                                        controller.updatePhone,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Color(0xFF111111),
                                                      letterSpacing: 0.5,
                                                    ),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                      LengthLimitingTextInputFormatter(
                                                        10,
                                                      ),
                                                    ],
                                                    decoration: const InputDecoration(
                                                      hintText:
                                                          "Enter Phone Number",
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 18,
                                                          ),
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (hasError)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                                top: 6,
                                              ),
                                              child: Text(
                                                controller.phoneError.value,
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    }),

                                  const SizedBox(height: 15),

                                  if (!controller.isOtpSent.value)
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Checkbox(
                                            activeColor: primaryRed,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
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

                                  if (controller.isOtpSent.value)
                                    controller.otpField(onCompleted: (otp) {}),

                                  const SizedBox(height: 15),

                                  GestureDetector(
                                    onTap: controller.sendOtp,
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 18,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [primaryRed, darkRed],
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller.isOtpSent.value
                                                  ? "VERIFY & PROCEED"
                                                  : "SEND OTP",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 1.1,
                                              ),
                                            ),
                                            if (controller.isOtpSent.value) ...[
                                              const SizedBox(width: 8),
                                              const Icon(
                                                Icons.arrow_forward_rounded,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  /// RESEND SECTION
                                  if (controller.isOtpSent.value) ...[
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton.icon(
                                          onPressed: controller.changeNumber,
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 4,
                                              vertical: 6,
                                            ),
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          icon: const Icon(
                                            Icons.edit_rounded,
                                            color: Colors.black45,
                                            size: 14,
                                          ),
                                          label: const Text(
                                            "Change Number",
                                            style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => TextButton.icon(
                                            onPressed:
                                                controller.canResend.value
                                                ? controller.resendOtp
                                                : null,
                                            style: TextButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 4,
                                                    vertical: 6,
                                                  ),
                                              minimumSize: Size.zero,
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            icon: Icon(
                                              Icons.replay_rounded,
                                              color: controller.canResend.value
                                                  ? primaryRed
                                                  : Colors.grey,
                                              size: 14,
                                            ),
                                            label: Text(
                                              controller.canResend.value
                                                  ? "Resend OTP"
                                                  : "Resend in ${controller.seconds.value}s",
                                              style: TextStyle(
                                                color:
                                                    controller.canResend.value
                                                    ? primaryRed
                                                    : Colors.grey,
                                                fontWeight: FontWeight.w700,
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
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
