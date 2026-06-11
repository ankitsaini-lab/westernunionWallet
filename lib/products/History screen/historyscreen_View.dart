import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/History%20screen/historyscreen_Controller.dart';
import 'package:transwallet/widgets/globalbottombar/Globalbottombar_View.dart';

class HistoryscreenView extends GetView<HistoryscreenController> {
  const HistoryscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<HistoryscreenController>()) {
      Get.lazyPut(() => HistoryscreenController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GlobalbottombarView(seletedIndex: 2.obs),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyActions: false,
        
        
        
        
        centerTitle: false,
        titleSpacing: 0,

        title: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            "All Transactions",
            style: TextStyle(
              color: Color(0xFF111111),
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
        ),
        actions: [
          Obx(() {
            final isSearch = controller.isSearchActive.value;
            return IconButton(
              icon: Icon(
                Icons.search_rounded,
                color: isSearch
                    ? const Color(0xFFE53935)
                    : const Color(0xFF111111),
              ),
              onPressed: () {
                controller.isSearchActive.value = !isSearch;
                if (controller.isSearchActive.value) {
                  controller.isFilterActive.value = false;
                } else {
                  controller.searchQuery.value = "";
                }
              },
            );
          }),
          Obx(() {
            final isFilter = controller.isFilterActive.value;
            return IconButton(
              icon: Icon(
                Icons.tune_rounded,
                color: isFilter
                    ? const Color(0xFFE53935)
                    : const Color(0xFF111111),
              ),
              onPressed: () {
                controller.isFilterActive.value = !isFilter;
                if (controller.isFilterActive.value) {
                  controller.isSearchActive.value = false;
                  controller.searchQuery.value = "";
                } else {
                  controller.selectedFilter.value = "all";
                }
              },
            );
          }),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchPanel(),
            _buildFilterPanel(),
            Expanded(
              child: Obx(() {
                final list = controller.filteredTransactions;

                if (list.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_rounded,
                          size: 48,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "No transactions found",
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final tx = list[index];
                    return transactionItem(tx);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchPanel() {
    return Obx(() {
      if (!controller.isSearchActive.value) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFECECEC)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (val) => controller.searchQuery.value = val,
            style: const TextStyle(color: Color(0xFF111111), fontSize: 14),
            decoration: InputDecoration(
              icon: const Icon(Icons.search, color: Color(0xFFE53935)),
              hintText: "Search transactions...",
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFilterPanel() {
    return Obx(() {
      if (!controller.isFilterActive.value) return const SizedBox.shrink();

      final current = controller.selectedFilter.value;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildFilterChip("all", "All", current == "all"),
              const SizedBox(width: 8),
              _buildFilterChip("income", "📥 Income", current == "income"),
              const SizedBox(width: 8),
              _buildFilterChip("expense", "💸 Expense", current == "expense"),
              const SizedBox(width: 8),
              _buildFilterChip("failed", "❌ Failed", current == "failed"),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildFilterChip(String filterVal, String label, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.selectedFilter.value = filterVal,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF111111) : const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF111111)
                : const Color(0xFFECECEC),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget transactionItem(Map<String, dynamic> tx) {
    final amount = (tx["amount"] as num).toDouble();
    final isCredit = tx["isCredit"] == true;
    final isFailed = tx["isFailed"] == true;

    return GestureDetector(
      onTap: () => Get.toNamed("/transactiondetails", arguments: {"tx": tx}),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFECECEC)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            avatar(tx["name"]?.toString() ?? ""),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx["name"]?.toString() ?? "Payment",
                    style: const TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        tx["date"]?.toString() ?? "",
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (isFailed) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEBEE),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "Failed",
                            style: TextStyle(
                              color: Color(0xFFC62828),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "${isCredit ? '+' : '-'} ₹${amount.abs()}",
              style: TextStyle(
                color: isCredit
                    ? const Color(0xFF2E7D32)
                    : isFailed
                    ? const Color(0xFFC62828)
                    : const Color(0xFF111111),
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
          ],
        ),
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
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(iconData, color: Colors.white, size: 20),
    );
  }
}
