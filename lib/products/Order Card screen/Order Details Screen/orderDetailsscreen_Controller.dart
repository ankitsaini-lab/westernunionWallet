import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderdetailsscreenController extends GetxController {
  var amount = 150.obs;
  var cardGradient = <Color>[const Color(0xFF111111), const Color(0xFF2C2C2C)].obs;
  var cardStyleName = "Obsidian Black".obs;
  var receiverName = "Jane Doe".obs;
  var deliveryAddress = "123 Ring Road, Delhi - 110001".obs;
  var deliveryDateStr = "".obs;
  var referenceId = "".obs;

  @override
  void onInit() {
    super.onInit();
    
    // Generate a unique dynamic Reference ID (TXN + random 8 digits)
    final rand = Random();
    final randomNum = 10000000 + rand.nextInt(90000000);
    referenceId.value = "TXN-$randomNum";

    // Dynamic delivery date set exactly 7 days in the future
    final targetDate = DateTime.now().add(const Duration(days: 7));
    final weekdayStr = _getWeekdayString(targetDate.weekday);
    final monthStr = _getMonthString(targetDate.month);
    deliveryDateStr.value = "$weekdayStr, ${targetDate.day} $monthStr ${targetDate.year}";

    // Retrieve arguments passed from payment screen, otherwise fallback to defaults
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      if (args.containsKey('amount')) {
        amount.value = args['amount'] is int ? args['amount'] : int.tryParse(args['amount'].toString()) ?? 150;
      }
      if (args.containsKey('cardGradient') && args['cardGradient'] is List<Color>) {
        cardGradient.assignAll(args['cardGradient'] as List<Color>);
      }
      if (args.containsKey('cardStyleName')) {
        cardStyleName.value = args['cardStyleName'].toString();
      }
      if (args.containsKey('receiverName')) {
        receiverName.value = args['receiverName'].toString();
      }
      if (args.containsKey('deliveryAddress')) {
        deliveryAddress.value = args['deliveryAddress'].toString();
      }
    }
  }

  String _getWeekdayString(int day) {
    switch (day) {
      case DateTime.monday: return "Monday";
      case DateTime.tuesday: return "Tuesday";
      case DateTime.wednesday: return "Wednesday";
      case DateTime.thursday: return "Thursday";
      case DateTime.friday: return "Friday";
      case DateTime.saturday: return "Saturday";
      case DateTime.sunday: return "Sunday";
      default: return "";
    }
  }

  String _getMonthString(int month) {
    switch (month) {
      case 1: return "Jan";
      case 2: return "Feb";
      case 3: return "Mar";
      case 4: return "Apr";
      case 5: return "May";
      case 6: return "Jun";
      case 7: return "Jul";
      case 8: return "Aug";
      case 9: return "Sep";
      case 10: return "Oct";
      case 11: return "Nov";
      case 12: return "Dec";
      default: return "";
    }
  }

  Widget row(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: const Color(0xFF111111),
                fontSize: 13,
                fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}