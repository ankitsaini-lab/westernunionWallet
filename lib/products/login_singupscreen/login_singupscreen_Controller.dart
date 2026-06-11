import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

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
    videoController = VideoPlayerController.asset("assets/videomp_.mp4")
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
  var isCheckedpopup = false.obs;
  final phoneController = TextEditingController();

  RxString phoneError = ''.obs;
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _bodyText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontSize: 13.5, height: 1.5)),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 14)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13.5, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  void toggleCheckbox(bool? value) {
    isCheckedpopup.value = value ?? false;
  }

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

    
    showPrivacyBottomSheet();
  }

  void showPrivacyBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.85,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          children: [
            
            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            
            const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  "User Data Privacy Policy",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const SizedBox(height: 12),

            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("1. Introduction"),

                    _bodyText(
                      'Transcorp International Ltd. ("Transcorp", "we", "our", "us") is committed to protecting the privacy and security of your personal data. This Policy explains how we collect, use, disclose, and safeguard your information when you use the TransWallet App or related services.',
                    ),

                    _sectionTitle("2. Information We Collect"),

                    const Text(
                      "We collect information necessary to provide our services, including:",
                      style: TextStyle(fontSize: 13.5, height: 1.5),
                    ),

                    _bullet(
                      "Personal Information: Name, contact details, DOB, address.",
                    ),

                    _bullet(
                      "KYC & Identity Data: PAN, Aadhaar, government-issued ID proofs, biometrics.",
                    ),

                    _bullet(
                      "Transaction Information: Account numbers, wallet transactions, payments, wallet loading and spends.",
                    ),

                    _bullet(
                      "Device & Technical Data: IP address, device type, operating system, location.",
                    ),

                    _bullet(
                      "Communication & Feedback: Emails, calls, chats with support.",
                    ),

                    _sectionTitle("3. Use of Information"),

                    const Text(
                      "We use your information to:",
                      style: TextStyle(fontSize: 13.5, height: 1.5),
                    ),

                    _bullet("Verify identity and complete KYC"),

                    _bullet("Provide wallet and payment services."),

                    _bullet("Detect and prevent fraud."),

                    _bullet("Enhance app functionality."),

                    _bullet("Comply with legal requirements."),

                    _bullet("Send alerts and updates."),

                    _sectionTitle("4. Sharing of Information"),

                    const Text(
                      "We may share your information with:",
                      style: TextStyle(fontSize: 13.5, height: 1.5),
                    ),

                    _bullet("Banks, payment networks, and service providers."),

                    _bullet("Government authorities where legally required."),

                    _bullet(
                      "Third-party vendors under confidentiality agreements.",
                    ),

                    _sectionTitle("5. Data Security"),

                    _bodyText(
                      "We implement industry-standard security measures including encryption and access controls.",
                    ),

                    _sectionTitle("6. Your Rights"),

                    const Text(
                      "You have the right to:",
                      style: TextStyle(fontSize: 13.5, height: 1.5),
                    ),

                    _bullet("Access or correct your data."),

                    _bullet("Withdraw consent where applicable."),

                    _bullet("Raise concerns with support."),

                    _sectionTitle("7. Data Retention"),

                    _bodyText(
                      "Personal data is retained only as long as necessary.",
                    ),

                    _sectionTitle("8. Updates to Policy"),

                    _bodyText("We may update this policy periodically."),

                    
                    _sectionTitle("9. Consent"),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Checkbox(
                            value: isCheckedpopup.value,
                            onChanged: toggleCheckbox,
                            activeColor: Colors.green,
                          ),
                        ),

                        Expanded(
                          child: GestureDetector(
                            onTap: () => toggleCheckbox(!isCheckedpopup.value),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "By registering or using the TransWallet App, you agree to the collection and use of your data as described in this policy.",
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.5,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            
            Row(
              children: [
                
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      isOtpSent.value = false;
                      Get.back();
                    },
                    child: const Text(
                      "Decline",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                
                Expanded(
                  child: Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isCheckedpopup.value
                            ? Colors.black
                            : Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: isCheckedpopup.value
                          ? () {
                              isOtpSent.value = true;

                              startTimer();

                              Get.back();

                              log("OTP Sent");
                            }
                          : null,
                      child: const Text(
                        "Agree & Continue",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _verifyOtp() {
    if (!isOtpComplete) {
      Get.snackbar("Error", "Please enter complete OTP");
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
    const primaryRed = Color(0xFFD64550);
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
