 
 
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

  

  

  RxList<Map<String, dynamic>> transactions = <Map<String, dynamic>>[
    {
      "name": "Blinkit",
      "date": "19 November",
      "amount": -240,
      "status": "success",
    },
    {
      "name": "Zomato India",
      "date": "9 November",
      "amount": -635,
      "status": "success",
    },
    {
      "name": "Zomato India",
      "date": "9 November",
      "amount": -635,
      "status": "failed",
    },
    {
      "name": "Jane Doe",
      "date": "15 November",
      "amount": 2500,
      "status": "credit",
    },
  ].obs;
}