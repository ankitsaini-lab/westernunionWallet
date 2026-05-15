import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Wallet%20Screen/walletscreen_Controller.dart';
import 'package:transwallet/widgets/globalbottombar/Globalbottombar_View.dart';

class WalletscreenView extends GetView<WalletscreenController> {
  const WalletscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<WalletscreenController>()) {
      Get.lazyPut(() => WalletscreenController());
    }

    // Defining the Theme Colors
    const primaryRed = Color(0xFFD64550);
    const darkRed = Color(0xFFB22B37);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Softer background
      bottomNavigationBar: GlobalbottombarView(seletedIndex: 1.obs),
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Digital Wallet",
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 24),
        ),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primaryRed, darkRed],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryRed.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Text(
                        "TOTAL BALANCE",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "₹9,200.00",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 32),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: controller.walletList()),
          ],
        ),
      ),
    );
  }
}

