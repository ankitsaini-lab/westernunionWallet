import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactiondetailsView extends StatelessWidget {
  const TransactiondetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};
    final tx = args["tx"] ?? {};

    
    final String name = tx["name"]?.toString() ?? "Payment Reference";
    final String date = tx["date"]?.toString() ?? "Today";
    final double amountValue = (tx["amount"] as num?)?.toDouble().abs() ?? 0.0;

    
    bool isCredit = false;
    if (tx.containsKey("isCredit")) {
      isCredit = tx["isCredit"] == true;
    } else if (tx.containsKey("amount")) {
      isCredit = (tx["amount"] as num) > 0;
    }

    
    String status = "success";
    if (tx.containsKey("isFailed")) {
      status = (tx["isFailed"] == true) ? "failed" : "success";
    } else if (tx.containsKey("status")) {
      status = tx["status"]?.toString().toLowerCase() ?? "success";
    }

    
    Color statusColor;
    IconData statusIcon;
    String statusText;
    Color statusBgColor;

    if (status == "failed") {
      statusColor = const Color(0xFFC62828);
      statusIcon = Icons.cancel_rounded;
      statusText = "Failed";
      statusBgColor = const Color(0xFFFFEBEE);
    } else if (status == "pending" || status == "processing") {
      statusColor = const Color(0xFFF57C00);
      statusIcon = Icons.watch_later_rounded;
      statusText = "Pending";
      statusBgColor = const Color(0xFFFFF3E0);
    } else {
      statusColor = const Color(0xFF2E7D32);
      statusIcon = Icons.check_circle_rounded;
      statusText = "Success";
      statusBgColor = const Color(0xFFE8F5E9);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyActions: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: false,
        titleSpacing: 0,
        title: const Text(
          "Transaction Receipt",
          style: TextStyle(
            color: Color(0xFF111111),
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFECECEC)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.only(top: 28, left: 24, right: 24, bottom: 20),
                      child: Column(
                        children: [
                          avatar(name),
                          const SizedBox(height: 16),
                          Text(
                            name,
                            style: const TextStyle(
                              color: Color(0xFF111111),
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${isCredit ? '+' : '-'} ₹${amountValue.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: isCredit ? const Color(0xFF2E7D32) : const Color(0xFF111111),
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: statusBgColor,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: statusColor.withOpacity(0.15)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(statusIcon, color: statusColor, size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  statusText,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 10,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: List.generate(
                                20,
                                (index) => Expanded(
                                  child: Container(
                                    height: 1.5,
                                    color: index % 2 == 0 ? Colors.transparent : const Color(0xFFECECEC),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 10,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),

                    
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _buildDetailRow("Transaction Type", isCredit ? "Income Received" : "Money Spent"),
                          _buildDetailRow("Reference ID", "TXN${tx.hashCode.abs().toString().padRight(10).substring(0, 10).toUpperCase()}"),
                          _buildDetailRow("Date & Time", date),
                          _buildDetailRow("Payment Source", "Western Union Wallet"),
                          _buildDetailRow("Standard Fee", "₹0.00"),
                          const Divider(color: Color(0xFFECECEC), height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Settled",
                                style: TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "₹${amountValue.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              
              GestureDetector(
                onTap: () {
                  Get.snackbar(
                    "Success",
                    "Receipt details shared successfully!",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF111111),
                    colorText: Colors.white,
                    borderRadius: 16,
                    margin: const EdgeInsets.all(16),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111111),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Share Receipt",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFECECEC)),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Back to Transactions",
                    style: TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF111111),
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget avatar(String name) {
    final lowerName = name.toLowerCase();
    IconData iconData = Icons.payment_rounded;
    List<Color> gradientColors = [
      const Color(0xFF424242),
      const Color(0xFF212121),
    ];

    if (lowerName.contains("zomato")) {
      iconData = Icons.restaurant_rounded;
      gradientColors = [const Color(0xFFE53935), const Color(0xFFB71C1C)];
    } else if (lowerName.contains("blinkit")) {
      iconData = Icons.shopping_bag_rounded;
      gradientColors = [const Color(0xFF43A047), const Color(0xFF1B5E20)];
    } else if (lowerName.contains("jane") ||
        lowerName.contains("doe") ||
        lowerName.contains("transfer") ||
        lowerName.contains("receive")) {
      iconData = Icons.swap_horiz_rounded;
      gradientColors = [const Color(0xFF1E88E5), const Color(0xFF0D47A1)];
    } else {
      iconData = Icons.wallet_rounded;
      gradientColors = [const Color(0xFF757575), const Color(0xFF424242)];
    }

    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(iconData, color: Colors.white, size: 28),
    );
  }
}
