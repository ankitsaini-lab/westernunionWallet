import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/widgets/constsize.dart';

class LoginSingupscreenController extends GetxController {
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
      style: const TextStyle(
        fontSize: 15.5,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _bodyText(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13.5,
        height: 1.5,
      ),
    ),
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
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.5,
            ),
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

  /// TIMER
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

  /// PHONE VALIDATION
  if (phone.isEmpty) {
    phoneError.value = "Mobile number is required";
    return;
  }

  if (phone.length != 10) {
    phoneError.value = "Enter valid 10 digit number";
    return;
  }

  /// CLEAR ERROR
  phoneError.value = "";

  /// OPEN PRIVACY SHEET
  showPrivacyBottomSheet();
}

void showPrivacyBottomSheet() {
  Get.bottomSheet(
    Container(
      height: Get.height * 0.85,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      child: Column(
        children: [
          /// TOP HANDLE
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          /// TITLE
          const Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.blue,
              ),
              SizedBox(width: 8),
              Text(
                "User Data Privacy Policy",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// CONTENT
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  _sectionTitle("1. Introduction"),

                  _bodyText(
                    'Transcorp International Ltd. ("Transcorp", "we", "our", "us") is committed to protecting the privacy and security of your personal data. This Policy explains how we collect, use, disclose, and safeguard your information when you use the TransWallet App or related services.',
                  ),

                  _sectionTitle(
                    "2. Information We Collect",
                  ),

                  const Text(
                    "We collect information necessary to provide our services, including:",
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.5,
                    ),
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

                  _sectionTitle(
                    "3. Use of Information",
                  ),

                  const Text(
                    "We use your information to:",
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.5,
                    ),
                  ),

                  _bullet(
                    "Verify identity and complete KYC",
                  ),

                  _bullet(
                    "Provide wallet and payment services.",
                  ),

                  _bullet(
                    "Detect and prevent fraud.",
                  ),

                  _bullet(
                    "Enhance app functionality.",
                  ),

                  _bullet(
                    "Comply with legal requirements.",
                  ),

                  _bullet(
                    "Send alerts and updates.",
                  ),

                  _sectionTitle(
                    "4. Sharing of Information",
                  ),

                  const Text(
                    "We may share your information with:",
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.5,
                    ),
                  ),

                  _bullet(
                    "Banks, payment networks, and service providers.",
                  ),

                  _bullet(
                    "Government authorities where legally required.",
                  ),

                  _bullet(
                    "Third-party vendors under confidentiality agreements.",
                  ),

                  _sectionTitle(
                    "5. Data Security",
                  ),

                  _bodyText(
                    "We implement industry-standard security measures including encryption and access controls.",
                  ),

                  _sectionTitle(
                    "6. Your Rights",
                  ),

                  const Text(
                    "You have the right to:",
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.5,
                    ),
                  ),

                  _bullet(
                    "Access or correct your data.",
                  ),

                  _bullet(
                    "Withdraw consent where applicable.",
                  ),

                  _bullet(
                    "Raise concerns with support.",
                  ),

                  _sectionTitle(
                    "7. Data Retention",
                  ),

                  _bodyText(
                    "Personal data is retained only as long as necessary.",
                  ),

                  _sectionTitle(
                    "8. Updates to Policy",
                  ),

                  _bodyText(
                    "We may update this policy periodically.",
                  ),

                  /// CONSENT
                  _sectionTitle("9. Consent"),

                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Checkbox(
                          value:
                              isCheckedpopup.value,
                          onChanged:
                              toggleCheckbox,
                          activeColor:
                              Colors.green,
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                                    vertical: 8,
                                  ),
                          child: Text(
                            "By registering or using the TransWallet App, you agree to the collection and use of your data as described in this policy.",
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.5,
                              color: Colors
                                  .blue
                                  .shade700,
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

          /// BUTTONS
          Row(
            children: [
              /// DECLINE
              Expanded(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.redAccent,
                        padding:
                            const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                                14,
                              ),
                        ),
                      ),
                  onPressed: () {
                    isOtpSent.value = false;
                    Get.back();
                  },
                  child: const Text(
                    "Decline",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              /// AGREE
              Expanded(
                child: Obx(
                  () => ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                              isCheckedpopup.value
                                  ? Colors.black
                                  : Colors
                                      .grey
                                      .shade300,
                          padding:
                              const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                  14,
                                ),
                          ),
                        ),
                    onPressed:
                        isCheckedpopup.value
                            ? () {
                              isOtpSent
                                  .value = true;

                              startTimer();

                              Get.back();

                              log(
                                "OTP Sent",
                              );
                            }
                            : null,
                    child: const Text(
                      "Agree & Continue",
                      style: TextStyle(
                        color: Colors.white,
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
  /// ---------------- TIMER ----------------
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
    _timer?.cancel();
    super.onClose();
  }

  /// ---------------- OTP CONTROLLERS ----------------
  final List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());

  final List<FocusNode> otpFocusNodes =
      List.generate(4, (_) => FocusNode());

  /// ---------------- OTP WIDGET ----------------
  Widget otpField({
    required Function(String otp) onCompleted,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 55,
          height: 55,
          child: TextField(
            controller: otpControllers[index],
            focusNode: otpFocusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: const Color(0xFFF2F2F2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFFE53935),
                  width: 1.2,
                ),
              ),
            ),

            onChanged: (value) {
              if (value.isNotEmpty) {
                if (index < 3) {
                  FocusScope.of(Get.context!)
                      .requestFocus(otpFocusNodes[index + 1]);
                } else {
                  FocusScope.of(Get.context!).unfocus();

                  otp.value =
                      otpControllers.map((e) => e.text).join();

                  onCompleted(otp.value);
                }
              } else {
                if (index > 0) {
                  FocusScope.of(Get.context!)
                      .requestFocus(otpFocusNodes[index - 1]);
                }
              }
            },
          ),
        );
      }),
    );
  }
}