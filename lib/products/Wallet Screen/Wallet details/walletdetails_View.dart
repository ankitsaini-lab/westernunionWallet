import 'dart:developer';
 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
import 'package:transwallet/products/Wallet%20Screen/Wallet%20details/walletdetails_controller.dart';

class WalletdetailsView extends GetView<WalletdetailsController> {
  const WalletdetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    
   Get.lazyPut(() => WalletdetailsController());
    
    return Scaffold(
      backgroundColor: Colors.white,
    appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  automaticallyImplyActions: false,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Get.back(),
  ),
  centerTitle: false,
  title: const Text(
    "Wallet Details",
    style: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
  ),
),
      body: SafeArea(
        child: Column(
          children: [
            walletCard(),
            transactionList(),
          ],
        ),
      ),
    );
  }

  
  Widget walletCard() {
    
    return Obx(() {
      final w = controller.wallet;

      if (w.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        );
      }

      final colors = (w["gradient"] is List<Color>)
          ? List<Color>.from(w["gradient"])
          : [Colors.grey, Colors.grey.shade400];

      return Container(
         
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(colors: colors),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                // icon(w["icon"]?.toString() ?? "💰"),
                // const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      Text(
                        w["title"]?.toString() ?? "Wallet",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Available Balance",
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "₹${w["balance"] ?? 0}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget icon(String emoji) {
    return Container(
      height: 65,
      width: 65,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }

 
  Widget transactionList() {
    
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "All Transactions",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount:  controller.transactions.length,
                    itemBuilder: (context, index) {
                      final tx = controller.transactions[index];
                      return transactionItem(tx);
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget transactionItem(Map<String, dynamic> tx) {
    final amount = (tx["amount"] as num).toDouble();
    final isCredit = amount > 0;
    final isFailed = tx["status"] == "failed";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          avatar(tx["name"]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx["name"],
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      tx["date"],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    if (isFailed) ...[
                      const SizedBox(width: 6),
                      const Text(
                        "• Failed",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 12,
                        ),
                      ),
                    ]
                  ],
                )
              ],
            ),
          ),
          Text(
            "${isCredit ? '+' : '-'} ₹${amount.abs()}",
            style: TextStyle(
              color: isCredit
                  ? Colors.green
                  : isFailed
                      ? Colors.red
                      : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  Widget avatar(String name) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white.withOpacity(0.2),
      child: Text(
        name.isNotEmpty ? name[0] : "?",
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}