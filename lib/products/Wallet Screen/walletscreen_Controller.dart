import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Wallet%20Screen/Add%20Money/addmoney_View.dart';

import 'dart:async';

class WalletscreenController extends GetxController {
  // Track which card is expanded to show buttons
  var expandedIndex = (-1).obs;

  // Global balance visibility state
  var isBalanceRevealed = false.obs;
  Timer? _autoHideTimer;

  void revealBalance() {
    isBalanceRevealed.value = true;
    _autoHideTimer?.cancel();
    _autoHideTimer = Timer(const Duration(seconds: 8), () {
      isBalanceRevealed.value = false;
    });
  }

  void hideBalance() {
    _autoHideTimer?.cancel();
    isBalanceRevealed.value = false;
  }

  @override
  void onClose() {
    _autoHideTimer?.cancel();
    super.onClose();
  }

  var wallets = [
    {
      "title": "General Wallet",
      "balance": 1600,
      "icon": "assets/walletcard/Generaldigital.jpg",
    },
    {
      "title": "Meal Wallet",
      "balance": 2000,
      "icon": "assets/walletcard/Digitalmeal.jpg",
    },
    {
      "title": "Fuel Wallet",
      "balance": 1600,
      "icon": "assets/walletcard/Digitalfuel.jpg",
    },
    {
      "title": "Medical Wallet",
      "balance": 2000,
      "icon": "assets/walletcard/Healthcare digital.jpg",
    },
    {
      "title": "NCMC Wallet",
      "balance": 2000,
      "icon": "assets/walletcard/Public transport.jpg",
    },
  ].obs;

  Widget walletList() {
    return Obx(() => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemCount: wallets.length,
          itemBuilder: (context, index) {
            final wallet = wallets[index];
            return walletCard(wallet, index);
          },
        ));
  }

  Widget walletCard(Map wallet, int index) {
    return Obx(() {
      bool isExpanded = expandedIndex.value == index;
      return GestureDetector(
        onTap: () => expandedIndex.value = isExpanded ? -1 : index,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white, 
             boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 6),
          )
        ],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // Circular Icon Image
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(wallet["icon"].toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Title and Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          wallet["title"],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Available Balance",
                          style: TextStyle(color: Colors.
                          black54, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  // Balance
                  Text(
                    "₹${wallet["balance"]}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.black54,
                  ),
                ],
              ),
           
              if (isExpanded) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    actionButton("Add Money", onTap: () {
                      Get.bottomSheet(
                        const AddmoneyView(showGeneralWalletOption: true),
                        isScrollControlled: true,
                        isDismissible: false,
                        enableDrag: false,
                        backgroundColor: Colors.transparent,
                      );
                    }),
                    const SizedBox(width: 12),
                    actionButton("Transactions", onTap: () {
                      Get.toNamed("/walletdetails", arguments: {"data": wallet});
                    }),
                  ],
                ),
              ]
            ],
          ),
        ),
      );
    });
  }
Widget actionButton(String text, {VoidCallback? onTap}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFD64550).withOpacity(0.1), // Soft red background
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFD64550).withOpacity(0.2)),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFFD64550), // Red text for a "decent" look
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

}
