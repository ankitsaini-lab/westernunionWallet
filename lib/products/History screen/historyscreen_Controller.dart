import 'package:get/get.dart';

class HistoryscreenController extends GetxController {
  var transactions = <Map<String, dynamic>>[].obs;

  var searchQuery = "".obs;
  var selectedFilter = "all".obs; // all, income, expense, failed
  var isSearchActive = false.obs;
  var isFilterActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  List<Map<String, dynamic>> get filteredTransactions {
    return transactions.where((tx) {
      final name = tx["name"]?.toString().toLowerCase() ?? "";
      final matchesSearch = name.contains(searchQuery.value.toLowerCase());
      
      if (!matchesSearch) return false;

      final isCredit = tx["isCredit"] == true;
      final isFailed = tx["isFailed"] == true;

      switch (selectedFilter.value) {
        case "income":
          return isCredit && !isFailed;
        case "expense":
          return !isCredit && !isFailed;
        case "failed":
          return isFailed;
        case "all":
        default:
          return true;
      }
    }).toList();
  }

  void loadData() {
    transactions.value = [
      {
        "name": "Blinkit",
        "date": "19 Nov • 01:20 PM",
        "amount": 240,
        "isCredit": false,
        "isFailed": false,
      },
      {
        "name": "Zomato India",
        "date": "9 Nov • 07:45 PM",
        "amount": 635,
        "isCredit": false,
        "isFailed": false,
      },
      {
        "name": "Zomato India",
        "date": "9 Nov • 07:45 PM",
        "amount": 635,
        "isCredit": false,
        "isFailed": true,
      },
      {
        "name": "Jane Doe",
        "date": "15 Nov • 10:10 AM",
        "amount": 2500,
        "isCredit": true,
        "isFailed": false,
      },
      {
        "name": "Blinkit",
        "date": "19 Nov • 01:20 PM",
        "amount": 240,
        "isCredit": false,
        "isFailed": false,
      },
    ];
  }
}