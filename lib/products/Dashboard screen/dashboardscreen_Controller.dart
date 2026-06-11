import 'dart:developer';
import 'dart:math';
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Wallet%20Screen/Add%20Money/addmoney_View.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/custombutton.dart';

class DashboardscreenController extends GetxController {
  RxBool isFlipped = false.obs;
  RxBool isVisible = false.obs;

  void flipCard() {
    isFlipped.value = !isFlipped.value;
  }

  @override
  void onInit() {
    
    super.onInit();
  }

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  Widget actionBtn(String icon, String text, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("$icon", height: 25, color: Colors.black),
              
              const SizedBox(height: 6),

              
              Text(
                text,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tile(String l, String t, String amt) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFD64550).withOpacity(0.1),
            child: Text(
              l,
              style: const TextStyle(
                color: Color(0xFFD64550),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              t,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Text(
            amt,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: amt.contains("+") ? Colors.green.shade700 : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFront({Key? key}) {
    return cardBase(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          topRow(),

          const SizedBox(height: 20),

          
          Obx(
            () => blurWrapper(
              isVisible.value,
              const Text(
                "1234 5678 9012 3456",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const Spacer(),

          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "VALID THRU 12/28",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                "VISA",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBack({Key? key}) {
    return cardBase(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Container(
            height: 38,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          const SizedBox(height: 12),

          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(height: 12, color: Colors.grey.shade300),
                ),

                const SizedBox(width: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: blurWrapper(
                    true,
                    const Text(
                      "123",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Colors.black,
                      ),
                    ),
                    
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 32,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Set PIN", style: TextStyle(fontSize: 12)),
              ),
            ),
          ),

          const Spacer(),

          const Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "VISA",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardBase({required Widget child, Key? key}) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),

        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFB71C1C), Color(0xFFD32F2F), Color(0xFFFF5252)],
        ),

        
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.35),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),

      child: Stack(
        children: [
          
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          child,
        ],
      ),
    );
  }

  Widget topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Prepaid Card", style: TextStyle(color: Colors.white)),

        Obx(
          () => GestureDetector(
            onTap: toggleVisibility,
            child: Icon(
              isVisible.value ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget blurWrapper(bool isVisible, Widget child) {
    print("ert>> isVisible: $isVisible");
    return isVisible
        ? child
        : Text(
            "**** **** **** 3456",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
            ),
          );
  }

  Widget walletCard({required showhide}) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 200,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF1C1C1E), Color(0xFF000000)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const SizedBox(height: 40),

                Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                height12,

                Row(
                  children: [
                    Text(
                      showhide == true ? "**** **** **** 1234" : " ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),

                
              ],
            ),
          ),

          Positioned(
            bottom: 15,
            left: 20,
            child: Text("CARD HOLDER", style: TextStyle(color: Colors.white54)),
          ),

          Positioned(
            top: 10,
            right: 10,
            child: Visibility(
              visible: showhide,
              child: GestureDetector(
                onTap: openCardDetails,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.visibility,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 45,
            left: 0,
            right: 0,
            child: Visibility(
              visible: showhide,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: SizedBox(width: 5)),
                  Expanded(
                    child: CustomButton(
                      prefixIcon: Icon(Icons.send, color: Colors.black),
                      text: "Transfer",
                      height: 40,
                      btncolor: Colors.white,
                      textColor: Colors.black,
                      onPressed: () {
                        Get.toNamed("/sendmoney");
                      },
                    ),
                  ),
                  width6,
                  Expanded(
                    child: CustomButton(
                      prefixIcon: const Icon(Icons.add, color: Colors.black),
                      text: "Top-up",
                      height: 40,
                      btncolor: Colors.white,
                      textColor: Colors.black,
                      onPressed: () {
                        Get.bottomSheet(
                          const AddmoneyView(showGeneralWalletOption: false),
                          isScrollControlled: true,
                          isDismissible: false,
                          enableDrag: false,
                          backgroundColor: Colors.transparent,
                        );
                      },
                    ),
                  ),
                  width8,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openCardDetails() {
    Get.dialog(
      Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),

            Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 240,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1C1C1E), Colors.black],
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          height32,
                          Container(
                            width: 45,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          height16,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "1234 5678 9012 3456",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 2,
                                ),
                              ),
                              copyIcon("1234 5678 9012 3456"),
                            ],
                          ),

                          const SizedBox(height: 10),

                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Expiry",
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "12/28",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "CARD HOLDER",
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ],
                              ),

                              
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "CVV",
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                  const SizedBox(height: 2),

                                  Row(
                                    children: [
                                      const Text(
                                        "123",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(width: 6),
                                      copyIcon("123"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 8,
                    right: 20,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget copyIcon(String text) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: text));
        Get.snackbar(
          "Copied",
          text,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      },
      child: const Icon(Icons.copy, color: Colors.white70, size: 18),
    );
  }

  Widget overlayRow(String text, {bool copy = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        if (copy)
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: text));
              Get.snackbar(
                "Copied",
                "Copied successfully",
                backgroundColor: Colors.black,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Icon(Icons.copy, color: Colors.white70, size: 18),
          ),
      ],
    );
  }

  Widget detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),

          Row(
            children: [
              Text(value, style: const TextStyle(color: Colors.white)),

              IconButton(
                icon: const Icon(Icons.copy, color: Colors.white),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: value));

                  Get.snackbar(
                    "Copied",
                    "$title copied",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.black,
                    colorText: Colors.white,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget actionButton(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (title == "Transfer") {
          print("Transfer clicked");
        }
        if (title == "Top Up") {
          print("TopUp clicked");
        }
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
