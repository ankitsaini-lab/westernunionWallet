 
 
import 'dart:developer';

import 'package:get/get.dart';

class WalletdetailsController extends GetxController {
  RxMap<String, dynamic> wallet = <String, dynamic>{}.obs;
  final argument = Get.arguments ?? {};
   @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    log("voice");
     if (argument["data"] != null) {
      wallet.value = Map<String, dynamic>.from(argument["data"]);
      log("✅ Wallet data received: ${wallet.value}");
    } else {
      log("⚠️ No wallet data received");
    }
  }

  

  

  var searchQuery = "".obs;
  var selectedFilter = "all".obs; // all, income, expense, failed
  var isSearchActive = false.obs;
  var isFilterActive = false.obs;

  List<Map<String, dynamic>> get filteredTransactions {
    return transactions.where((tx) {
      final name = tx["name"]?.toString()?.toLowerCase() ?? "";
      final matchesSearch = name.contains(searchQuery.value.toLowerCase());
      
      if (!matchesSearch) return false;

      final amount = (tx["amount"] as num).toDouble();
      final status = tx["status"]?.toString() ?? "";

      switch (selectedFilter.value) {
        case "income":
          return amount > 0;
        case "expense":
          return amount < 0 && status != "failed";
        case "failed":
          return status == "failed";
        case "all":
        default:
          return true;
      }
    }).toList();
  }

  RxList<Map<String, dynamic>> transactions = <Map<String, dynamic>>[
    {
      "name": "Blinkit",
      "date": "19 November • 02:30 PM",
      "amount": -240,
      "status": "success",
    },
    {
      "name": "Zomato India",
      "date": "9 November • 08:15 PM",
      "amount": -635,
      "status": "success",
    },
    {
      "name": "Zomato India",
      "date": "9 November • 08:15 PM",
      "amount": -635,
      "status": "failed",
    },
    {
      "name": "Jane Doe",
      "date": "15 November • 11:45 AM",
      "amount": 2500,
      "status": "credit",
    },
  ].obs;
}