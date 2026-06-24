import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/widgets/globalbottombar/GlobalbottomBar_Controller.dart';

class GlobalbottombarView extends GetView<GlobalbottombarController> {
  final RxInt seletedIndex;

  const GlobalbottombarView({super.key, required this.seletedIndex});

  static const Color primaryRed = Color(0xFFFFCC00);
  static const Color activeBgColor = Color(0xFFFFFBE6);
  static const Color textColor = Color(0xFF111111);
  static const Color greyColor = Color(0xFF6B7280);
  static const Color borderColor = Color(0xFFECECEC);

  
  static const List<Map<String, dynamic>> _tabs = [
    {'label': 'Home', 'icon': Icons.home_rounded, 'backendIndex': 0},
    {'label': 'Wallet', 'icon': Icons.credit_card_rounded, 'backendIndex': 1},
    {'label': 'Analytics', 'icon': Icons.bar_chart_rounded, 'backendIndex': 99},
    {'label': 'History', 'icon': Icons.history_rounded, 'backendIndex': 2},
    {'label': 'Profile', 'icon': Icons.person_rounded, 'backendIndex': 3},
  ];

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GlobalbottombarController());

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 74,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: primaryRed.withOpacity(0.02),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_tabs.length, (index) {
            final tab = _tabs[index];
            final int backendIndex = tab['backendIndex'];

            final bool isSelected = backendIndex == 99
                ? false
                : seletedIndex.value == backendIndex;

            return _TabButton(
              icon: tab['icon'] as IconData,
              label: tab['label'] as String,
              isSelected: isSelected,
              onTap: () {
                if (backendIndex == 99) {
                  _showAnalyticsBottomSheet();
                } else {
                  controller.changeIndex(backendIndex);
                  seletedIndex.value = backendIndex;
                }
              },
            );
          }),
        ),
      ),
    );
  }

  void _showAnalyticsBottomSheet() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Analytics Summary",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Your spending habits this month",
                      style: TextStyle(color: greyColor, fontSize: 13),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close_rounded, color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSheetStat("Shopping", "₹8,240", primaryRed),
                _buildSheetStat("Dining", "₹6,320", Colors.orange),
                _buildSheetStat("Travel", "₹3,680", Colors.blue),
              ],
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: textColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildSheetStat(String label, String value, Color color) {
    return Container(
      width: Get.width * 0.26,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.12), width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}


class _TabButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<_TabButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.90 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: widget.isSelected ? 16 : 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? GlobalbottombarView.activeBgColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: widget.isSelected
                    ? GlobalbottombarView.primaryRed
                    : GlobalbottombarView.greyColor,
                size: widget.isSelected ? 24 : 22,
              ),
              
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOutCubic,
                child: widget.isSelected
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 8),
                          Text(
                            widget.label,
                            style: const TextStyle(
                              color: GlobalbottombarView.primaryRed,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.1,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
