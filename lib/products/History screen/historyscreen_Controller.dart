import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryscreenController extends GetxController {
   var transactions = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    transactions.value = [
      {
        "name": "Blinkit",
        "date": "19 Nov",
        "amount": 240,
        "isCredit": false,
        "isFailed": false,
      },
      {
        "name": "Zomato India",
        "date": "9 Nov",
        "amount": 635,
        "isCredit": false,
        "isFailed": false,
      },
      {
        "name": "Zomato India",
        "date": "9 Nov",
        "amount": 635,
        "isCredit": false,
        "isFailed": true,
      },
      {
        "name": "Jane Doe",
        "date": "15 Nov",
        "amount": 2500,
        "isCredit": true,
        "isFailed": false,
      },
      {
        "name": "Blinkit",
        "date": "19 Nov",
        "amount": 240,
        "isCredit": false,
        "isFailed": false,
      },
    ];
  }
   Widget transactionCard(Map tx) {
  const primaryRed = Color(0xFFD64550);
  bool isFailed = tx["isFailed"];

  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 12,
          offset: const Offset(0, 4),
        )
      ],
    ),
    child: Row(
      children: [
        avatar(tx["name"]),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tx["name"],
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                tx["date"],
                style: const TextStyle(fontSize: 12, color: Colors.black45),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${tx["isCredit"] ? "+" : "-"} ₹${tx["amount"]}",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: tx["isCredit"] ? Colors.green.shade700 : Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            statusChip(
              isFailed ? "Failed" : "Success",
              isFailed ? primaryRed : Colors.green.shade600,
            ),
          ],
        ),
      ],
    ),
  );
}
Widget avatar(String name) {
  return Container(
    height: 48,
    width: 48,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: const Color(0xFFD64550).withOpacity(0.08),
    ),
    child: Center(
      child: Text(
        name[0],
        style: const TextStyle(
          color: Color(0xFFD64550),
          fontWeight: FontWeight.w900,
          fontSize: 18,
        ),
      ),
    ),
  );
}
  Widget statusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}