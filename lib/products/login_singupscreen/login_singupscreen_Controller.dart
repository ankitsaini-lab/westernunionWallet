import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:transwallet/utilities/getStorage.dart';

class LoginSingupscreenController extends GetxController {
  late VideoPlayerController videoController;
  var isVideoInitialized = false.obs;

  final phoneFocusNode = FocusNode();
  var isPhoneFocused = false.obs;

  @override
  void onInit() {
    super.onInit();
    phoneFocusNode.addListener(() {
      isPhoneFocused.value = phoneFocusNode.hasFocus;
    });
    videoController = VideoPlayerController.asset("assets/videounion.mp4")
      ..initialize().then((_) {
        isVideoInitialized.value = true;
        videoController.setLooping(true);
        videoController.play();
        videoController.setVolume(0.0);
      });
  }

  var phone = ''.obs;
  var isChecked = false.obs;
  var isOtpSent = false.obs;
  var isPressed = false.obs;
  final phoneController = TextEditingController();

  RxString phoneError = ''.obs;

  var otp = ''.obs;

  var seconds = 60.obs;
  var canResend = false.obs;
  Timer? _timer;

  bool get isValidPhone => phone.value.length == 10;
  bool get canSendOtp => isValidPhone && isChecked.value;
  bool get isOtpComplete => otp.value.length == 4;

  void updatePhone(String value) {
    phone.value = value;
  }

  void toggleCheck(bool? value) {
    isChecked.value = value ?? false;
  }

  void sendOtp() {
    if (!isOtpSent.value) {
      _sendOtp();
    } else {
      _verifyOtp();
    }
  }

  void _sendOtp() {
    final phone = phoneController.text.trim();

    if (phone.isEmpty) {
      phoneError.value = "Mobile number is required";
      return;
    }

    if (phone.length != 10) {
      phoneError.value = "Enter valid 10 digit number";
      return;
    }

    phoneError.value = "";

    isOtpSent.value = true;
    startTimer();
    log("OTP Sent");
  }

  void _verifyOtp() {
    if (!isOtpComplete) {
      Get.snackbar("Error", "Please enter complete OTP");
      return;
    }

    final enteredPhone = phoneController.text.trim();
    if (enteredPhone == "9876543210" && otp.value == "1234") {
      box.write('name', "Vince Tallent");
      box.write('email', "vince.tallent@westernunion.com");
      box.write('phone', "9876543210");
      box.write('address', "Blk 222 Jurong Street 21,#06-222,Singapore 600222");
      box.write('pan', "ABCDE1234f");
      box.write('balance', 10000.0);

      log("OTP Verified for Vince Tallent. Navigating directly to Dashboard.");
      Get.offAllNamed('/dashboard');
      return;
    }

    log("OTP Verified");
    Get.toNamed('/createaccountview');
  }

  void startTimer() {
    seconds.value = 60;
    canResend.value = false;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    if (!canResend.value) return;

    clearOtp();

    startTimer();
  }

  void changeNumber() {
    isOtpSent.value = false;
    _timer?.cancel();
    clearOtp();
  }

  void clearOtp() {
    otp.value = '';
    for (var c in otpControllers) {
      c.clear();
    }
  }

  @override
  void onClose() {
    phoneFocusNode.dispose();
    videoController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<FocusNode> otpFocusNodes = List.generate(4, (_) => FocusNode());

  Widget otpField({required Function(String otp) onCompleted}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return PremiumOtpCell(
          controller: otpControllers[index],
          focusNode: otpFocusNodes[index],
          index: index,
          onChanged: (value) {
            otp.value = otpControllers.map((e) => e.text).join();

            if (value.isNotEmpty) {
              if (index < 3) {
                FocusScope.of(
                  Get.context!,
                ).requestFocus(otpFocusNodes[index + 1]);
              } else {
                FocusScope.of(Get.context!).unfocus();
                onCompleted(otp.value);
              }
            } else {
              if (index > 0) {
                FocusScope.of(
                  Get.context!,
                ).requestFocus(otpFocusNodes[index - 1]);
              }
            }
          },
        );
      }),
    );
  }
}

class PremiumOtpCell extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final int index;
  final Function(String) onChanged;

  const PremiumOtpCell({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.index,
    required this.onChanged,
  });

  @override
  State<PremiumOtpCell> createState() => _PremiumOtpCellState();
}

class _PremiumOtpCellState extends State<PremiumOtpCell> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = widget.focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryRed = Color(0xFFFFCC00);
    final bool hasText = widget.controller.text.isNotEmpty;

    return AnimatedScale(
      scale: _isFocused ? 1.06 : 1.0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutBack,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        width: 54,
        height: 58,
        decoration: BoxDecoration(
          color: _isFocused ? Colors.white : const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isFocused
                ? primaryRed
                : (hasText
                      ? const Color.fromARGB(62, 17, 17, 17)
                      : const Color(0xFFE5E7EB)),
            width: _isFocused ? 2.0 : 1.5,
          ),
          boxShadow: [
            if (_isFocused)
              BoxShadow(
                color: primaryRed.withOpacity(0.18),
                blurRadius: 20,
                offset: const Offset(0, 8),
              )
            else if (hasText)
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: TextField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 17, 17, 17),
                    letterSpacing: 0,
                  ),
                  showCursor: false,
                  decoration: InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "•",
                    hintStyle: TextStyle(
                      color: primaryRed.withOpacity(0.25),
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (val) {
                    setState(() {});
                    widget.onChanged(val);
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                height: 3,
                width: _isFocused ? 24 : (hasText ? 8 : 4),
                decoration: BoxDecoration(
                  color: _isFocused
                      ? primaryRed
                      : (hasText
                            ? const Color(0xFF111111)
                            : const Color(0xFFD1D5DB)),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
