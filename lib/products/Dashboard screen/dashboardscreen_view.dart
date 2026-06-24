import 'dart:async';
import 'dart:ui' show ImageFilter;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:transwallet/products/Dashboard%20screen/dashboardscreen_Controller.dart';
import 'package:transwallet/products/Notification%20screen/notification_View.dart';
import 'package:transwallet/products/Wallet%20Screen/Add%20Money/addmoney_View.dart';
import 'package:transwallet/widgets/globalbottombar/Globalbottombar_View.dart';
import 'package:transwallet/utilities/getStorage.dart';
import 'package:transwallet/widgets/premium_visa_card.dart';

const Color _primaryRed = Color(0xFFFFCC00);
const Color _secondaryRed = Color(0xFFFFB300);
const Color _textColor = Color(0xFF111111);
const Color _secondaryText = Color(0xFF6B7280);
const Color _borderColor = Color(0xFFECECEC);
const Color _backgroundColor = Colors.white;

class DashboardscreenView extends StatefulWidget {
  const DashboardscreenView({super.key});

  static const Color primaryRed = _primaryRed;
  static const Color secondaryRed = _secondaryRed;
  static const Color textColor = _textColor;
  static const Color secondaryText = _secondaryText;
  static const Color borderColor = _borderColor;
  static const Color backgroundColor = Colors.white;

  @override
  State<DashboardscreenView> createState() => _DashboardscreenViewState();
}

class _DashboardscreenViewState extends State<DashboardscreenView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DashboardscreenController());

    final String greeting = _getGreeting();

    return Scaffold(
      backgroundColor: _backgroundColor,
      bottomNavigationBar: GlobalbottombarView(seletedIndex: 0.obs),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                _animateWidget(
                  delayIndex: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _primaryRed.withOpacity(0.15),
                                width: 2,
                              ),
                              image: const DecorationImage(
                                image: AssetImage(
                                  "assets/360_F_244436923_vkMe10KKKiw5bjhZeRDT05moxWcPpdmb.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                greeting,
                                style: const TextStyle(
                                  color: _secondaryText,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.1,
                                ),
                              ),
                              Text(
                                box.read('name') ?? "Jane Doe",
                                style: const TextStyle(
                                  color: _textColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            NotificationView(),
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: _borderColor, width: 1.5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: _textColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                _animateWidget(
                  delayIndex: 1,
                  child: const _PremiumBalanceSection(),
                ),

                const SizedBox(height: 14),

                _animateWidget(
                  delayIndex: 2,
                  child: const _PremiumCardsSection(),
                ),

                const SizedBox(height: 14),

                _animateWidget(delayIndex: 3, child: _buildQuickActions()),

                const SizedBox(height: 14),

                _animateWidget(delayIndex: 4, child: _buildKycBanner()),

                const SizedBox(height: 14),

                _animateWidget(delayIndex: 5, child: _buildAnalyticsSection()),

                const SizedBox(height: 14),

                _animateWidget(
                  delayIndex: 6,
                  child: _buildRecentTransactionsSection(),
                ),

                const SizedBox(height: 14),

                _animateWidget(delayIndex: 7, child: _buildOffersSection()),

                const SizedBox(height: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _QuickActionButton(
            icon: Icons.send_rounded,
            label: "Send Money",
            onTap: () => Get.toNamed("/sendmoney"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.add_rounded,
            label: "Add Money",
            onTap: _openTopUpSheet,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.receipt_long_rounded,
            label: "Pay Bill",
            onTap: () => Get.to(
              () => const _PayBillScreen(),
              transition: Transition.cupertino,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBillersSection() {
    final billers = [
      {
        "icon": Icons.bolt_rounded,
        "label": "Electricity",
        "color": const Color(0xFFFFA726),
      },
      {
        "icon": Icons.phone_android_rounded,
        "label": "Mobile",
        "color": const Color(0xFF42A5F5),
      },
      {
        "icon": Icons.tv_rounded,
        "label": "DTH",
        "color": const Color(0xFF7E57C2),
      },
      {
        "icon": Icons.water_drop_rounded,
        "label": "Water",
        "color": const Color(0xFF26C6DA),
      },
      {
        "icon": Icons.local_gas_station_rounded,
        "label": "Gas",
        "color": const Color(0xFF66BB6A),
      },
      {
        "icon": Icons.wifi_rounded,
        "label": "Broadband",
        "color": const Color(0xFFEF5350),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Pay Bills",
              style: TextStyle(
                color: _textColor,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),
            TextButton(
              onPressed: () => _showComingSoonBottomSheet("All Billers"),
              child: const Text(
                "See All",
                style: TextStyle(
                  color: _primaryRed,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: billers.map((b) {
              final color = b["color"] as Color;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => _showComingSoonBottomSheet(b["label"] as String),
                  child: Column(
                    children: [
                      Container(
                        height: 58,
                        width: 58,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: color.withOpacity(0.18),
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          b["icon"] as IconData,
                          color: color,
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        b["label"] as String,
                        style: const TextStyle(
                          color: _textColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildKycBanner() {
    return _PressableScale(
      onTap: () => Get.toNamed("/updateKyc"),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: _borderColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: _primaryRed.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.verified_user_rounded,
                color: _primaryRed,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Complete your Full KYC",
                    style: TextStyle(
                      color: _textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Unlock higher wallet limits and premium neobank benefits.",
                    style: TextStyle(
                      color: _secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _primaryRed,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _primaryRed.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Text(
                    "Verify",
                    style: TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xFF111111),
                    size: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Spending Analytics",
                style: TextStyle(
                  color: _textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _primaryRed.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "This Month",
                  style: TextStyle(
                    color: _primaryRed,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 120,
            width: double.infinity,
            child: CustomPaint(painter: _BezierChartPainter()),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem("Income", "₹58,400", const Color(0xFF4CAF50)),
              _buildStatItem("Expenses", "₹18,240", _primaryRed),
              _buildStatItem("Savings", "₹40,160", const Color(0xFF2196F3)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color indicatorColor) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: indicatorColor,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: _secondaryText,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: _textColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentTransactionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Transactions",
              style: TextStyle(
                color: _textColor,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed("/history");
              },
              child: const Text(
                "See All",
                style: TextStyle(
                  color: _textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _borderColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildTransactionItem(
                initial: "B",
                merchant: "Blinkit",
                category: "Groceries",
                amount: "- ₹240",
                isCredit: false,
                isLast: false,
              ),
              _buildTransactionItem(
                initial: "Z",
                merchant: "Zomato",
                category: "Food Delivery",
                amount: "- ₹635",
                isCredit: false,
                isLast: false,
              ),
              _buildTransactionItem(
                initial: "Z",
                merchant: "Zomato",
                category: "Food Delivery",
                amount: "- ₹289",
                isCredit: false,
                isLast: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem({
    required String initial,
    required String merchant,
    required String category,
    required String amount,
    required bool isCredit,
    required bool isLast,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: _primaryRed.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  initial,
                  style: const TextStyle(
                    color: _primaryRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      merchant,
                      style: const TextStyle(
                        color: _textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      category,
                      style: const TextStyle(
                        color: _secondaryText,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                amount,
                style: TextStyle(
                  color: isCredit
                      ? const Color(0xFF2E7D32)
                      : const Color(0xFFD32F2F),
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(color: _borderColor, height: 1, thickness: 1),
          ),
      ],
    );
  }

  Widget _buildOffersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Offers & Insights",
          style: TextStyle(
            color: _textColor,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildOfferCard(
                title: "5% Instant Cashback",
                subtitle:
                    "Unlock reward points on utility bills paid via wallet card.",
                tag: "CASHBACK",
              ),
              const SizedBox(width: 16),
              _buildOfferCard(
                title: "Premium Membership",
                subtitle:
                    "Get zero fee transfers and special rates on foreign spends.",
                tag: "LUXURY",
              ),
              const SizedBox(width: 16),
              _buildOfferCard(
                title: "Reward Points Program",
                subtitle:
                    "Earn 2x rewards on every online purchase this weekend.",
                tag: "POINTS",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOfferCard({
    required String title,
    required String subtitle,
    required String tag,
  }) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _primaryRed.withOpacity(0.12), width: 1.5),
        gradient: LinearGradient(
          colors: [
            _primaryRed.withOpacity(0.08),
            _secondaryRed.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _primaryRed,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                color: Color(0xFF111111),
                fontSize: 9,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: _textColor,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: _secondaryText,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  void _openTopUpSheet() {
    Get.bottomSheet(
      const AddmoneyView(showGeneralWalletOption: false),
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
    );
  }

  void _showComingSoonBottomSheet(String feature) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: _primaryRed.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.hourglass_empty_rounded,
                color: _primaryRed,
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "$feature Coming Soon",
              style: const TextStyle(
                color: _textColor,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "We are working hard to bring this feature to your wallet app very soon. Stay tuned!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _secondaryText,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _textColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Awesome",
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

  Widget _animateWidget({required int delayIndex, required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (delayIndex * 80)),
      curve: Curves.easeOutQuad,
      builder: (context, value, childWidget) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: childWidget,
          ),
        );
      },
      child: child,
    );
  }
}

class _PremiumBalanceSection extends StatefulWidget {
  const _PremiumBalanceSection();

  @override
  State<_PremiumBalanceSection> createState() => _PremiumBalanceSectionState();
}

class _PremiumBalanceSectionState extends State<_PremiumBalanceSection> {
  bool _isRevealed = false;
  Timer? _autoHideTimer;

  void _toggleBalance() {
    if (_isRevealed) {
      _autoHide();
    } else {
      _showMpinSheet();
    }
  }

  void _reveal() {
    setState(() {
      _isRevealed = true;
    });

    _autoHideTimer?.cancel();
    _autoHideTimer = Timer(const Duration(seconds: 8), () {
      if (mounted) {
        setState(() {
          _isRevealed = false;
        });
      }
    });
  }

  void _autoHide() {
    _autoHideTimer?.cancel();
    setState(() {
      _isRevealed = false;
    });
  }

  @override
  void dispose() {
    _autoHideTimer?.cancel();
    super.dispose();
  }

  void _showMpinSheet() {
    Get.bottomSheet(
      _MpinVerifySheet(
        onSuccess: _reveal,
        title: "Enter MPIN to View Balance",
        subtitle: "For your security, enter your 4-digit mobile PIN",
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _showViewCardMpin() {
    Get.bottomSheet(
      _MpinVerifySheet(
        onSuccess: () {
          _showFullCardPopup();
        },
        title: "Verify MPIN",
        subtitle: "Enter MPIN to view your card",
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _showFullCardPopup() {
    Get.dialog(const _FullCardDetailsPopup(), barrierColor: Colors.transparent);
  }

  @override
  Widget build(BuildContext context) {
    const Color _primaryRed = Color(0xFFFFCC00);
    const Color _textColor = Color(0xFF111111);
    const Color _secondaryText = Color(0xFF6B7280);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Total Balance",
                    style: TextStyle(
                      color: _secondaryText,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _toggleBalance,
                    child: Icon(
                      _isRevealed
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: Color(0xFF111111),
                      size: 17,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _toggleBalance,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedCrossFade(
                      firstChild: const Text(
                        "₹ ••••••",
                        style: TextStyle(
                          color: _textColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                      secondChild: Text(
                        "₹${(box.read('balance') ?? 45280.50).toStringAsFixed(2)}",
                        style: TextStyle(
                          color: _textColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.8,
                        ),
                      ),
                      crossFadeState: _isRevealed
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 250),
                    ),
                    if (!_isRevealed) ...[
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFFFCC00).withOpacity(0.15),
                        ),
                        child: const Icon(
                          Icons.lock_outline_rounded,
                          color: Color(0xFF111111),
                          size: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //   decoration: BoxDecoration(
          //     color: _primaryRed.withOpacity(0.08),
          //     borderRadius: BorderRadius.circular(10),
          //     border: Border.all(color: _primaryRed.withOpacity(0.12)),
          //   ),
          //   child: const Text(
          //     "PREMIUM",
          //     style: TextStyle(
          //       color: _primaryRed,
          //       fontSize: 10,
          //       fontWeight: FontWeight.bold,
          //       letterSpacing: 0.8,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

const List<Map<String, dynamic>> _kCards = [
  {
    'label': 'Prepaid Card',
    'number': '•••• •••• •••• 1234',
    'fullNumber': '1234  5678  9012  1234',
    'expiry': '12/28',
    'holder': 'JANE DOE',
    'cvv': '123',
    'bgImage': 'assets/unioncardblack.webp',
    'colors': [Color(0xFF111111), Color(0xFF222222), Color(0xFF333333)],
  },
  {
    'label': 'Premium Card',
    'number': '•••• •••• •••• 5678',
    'fullNumber': '5678  1234  9012  5678',
    'expiry': '12/28',
    'holder': 'JANE DOE',
    'cvv': '456',
    'bgImage': 'assets/unioncardyellow.webp',
    'colors': [Color(0xFFE5A93C), Color(0xFFF7D070)],
    'useBlackLogos': true,
  },
];

class _PremiumCardsSection extends StatefulWidget {
  const _PremiumCardsSection();

  @override
  State<_PremiumCardsSection> createState() => _PremiumCardsSectionState();
}

class _PremiumCardsSectionState extends State<_PremiumCardsSection> {
  int _activeIndex = 0;

  void _onCardTap(int index) {
    Get.bottomSheet(
      _MpinVerifySheet(
        onSuccess: () {
          Get.dialog(
            _CardDetailsPopup(card: _kCards[index]),
            barrierColor: Colors.transparent,
          );
        },
        title: 'Verify MPIN',
        subtitle: 'Enter MPIN to view card details',
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Cards',
                style: TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: PageController(
              viewportFraction: _kCards.length == 1 ? 1.0 : 0.88,
            ),
            itemCount: _kCards.length,
            onPageChanged: (i) => setState(() => _activeIndex = i),
            itemBuilder: (context, index) {
              final card = _kCards[index];
              final colors = card['colors'] as List<Color>;
              return _PressableScale(
                onTap: () => _onCardTap(index),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: _kCards.length == 1 ? 0 : 14,
                    bottom: 8,
                  ),
                  child: Center(
                    child: PremiumVisaCard(
                      cardNumber: card['fullNumber'] as String,
                      cardHolder:
                          GetStorage().read('name') ?? card['holder'] as String,
                      expiryDate: card['expiry'] as String,
                      cvv: "•••",
                      bgImage:
                          card['bgImage'] as String? ??
                          'assets/unioncardblack.webp',
                      useBlackLogos: card['useBlackLogos'] as bool? ?? false,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        if (_kCards.length > 1) ...[
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_kCards.length, (i) {
              final isActive = i == _activeIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFFFCC00)
                      : const Color(0xFFFFCC00).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => Get.to(
            () => const ServicesMoreScreen(),
            transition: Transition.cupertino,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'View More',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SizedBox(width: 4),
              // Icon(
              //   Icons.arrow_forward_ios_rounded,
              //   color: Colors.black,
              //   size: 14,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<_QuickActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _primaryRed.withOpacity(0.45),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _primaryRed.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: _primaryRed,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _primaryRed.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  widget.icon,
                  color: const Color(0xFF111111),
                  size: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.label,
                style: const TextStyle(
                  color: _textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MpinVerifySheet extends StatefulWidget {
  final VoidCallback onSuccess;
  final String title;
  final String subtitle;

  const _MpinVerifySheet({
    required this.onSuccess,
    this.title = "Enter MPIN to View Balance",
    this.subtitle = "For your security, enter your 4-digit mobile PIN",
  });

  @override
  State<_MpinVerifySheet> createState() => _MpinVerifySheetState();
}

class _MpinVerifySheetState extends State<_MpinVerifySheet> {
  String _mpin = "";
  bool _isVerifying = false;
  bool _hasError = false;

  void _keypadPress(String value) {
    if (_mpin.length < 4 && !_isVerifying) {
      setState(() {
        _mpin += value;
        _hasError = false;
      });

      if (_mpin.length == 4) {
        _verifyMpin();
      }
    }
  }

  void _deletePress() {
    if (_mpin.isNotEmpty && !_isVerifying) {
      setState(() {
        _mpin = _mpin.substring(0, _mpin.length - 1);
        _hasError = false;
      });
    }
  }

  void _biometricPress() {
    setState(() {
      _isVerifying = true;
    });

    Timer(const Duration(milliseconds: 800), () {
      if (mounted) {
        Get.back();
        widget.onSuccess();
      }
    });
  }

  void _verifyMpin() {
    setState(() {
      _isVerifying = true;
    });

    Timer(const Duration(milliseconds: 1000), () {
      if (mounted) {
        if (_mpin == "1234" || _mpin == "0000" || _mpin.length == 4) {
          Get.back();
          widget.onSuccess();
        } else {
          setState(() {
            _mpin = "";
            _isVerifying = false;
            _hasError = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color _primaryRed = Color(0xFFFFCC00);
    const Color _textColor = Color(0xFF111111);
    const Color _secondaryText = Color(0xFF6B7280);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFECECEC),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primaryRed.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: Color(0xFF111111),
              size: 28,
            ),
          ),
          const SizedBox(height: 16),

          Text(
            widget.title,
            style: const TextStyle(
              color: _textColor,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.subtitle,
            style: const TextStyle(color: _secondaryText, fontSize: 13),
          ),
          const SizedBox(height: 28),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              final bool isFilled = index < _mpin.length;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isVerifying
                      ? _primaryRed.withOpacity(0.3)
                      : (isFilled ? _primaryRed : const Color(0xFFECECEC)),
                  border: Border.all(
                    color: _hasError ? Colors.red : Colors.transparent,
                    width: 2,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),

          if (_isVerifying) ...[
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(_primaryRed),
              ),
            ),
            const SizedBox(height: 16),
          ] else if (_hasError) ...[
            const Text(
              "Invalid MPIN. Try again.",
              style: TextStyle(
                color: Colors.red,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
          ] else ...[
            const SizedBox(height: 36),
          ],

          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildKeypadNum("1"),
                  _buildKeypadNum("2"),
                  _buildKeypadNum("3"),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildKeypadNum("4"),
                  _buildKeypadNum("5"),
                  _buildKeypadNum("6"),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildKeypadNum("7"),
                  _buildKeypadNum("8"),
                  _buildKeypadNum("9"),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildKeypadAction(
                    icon: Icons.fingerprint_rounded,
                    onTap: _biometricPress,
                  ),
                  _buildKeypadNum("0"),
                  _buildKeypadAction(
                    icon: Icons.backspace_outlined,
                    onTap: _deletePress,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: _secondaryText,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadNum(String number) {
    return _PressableScale(
      onTap: () => _keypadPress(number),
      child: Container(
        height: 64,
        width: Get.width * 0.25,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          number,
          style: const TextStyle(
            color: Color(0xFF111111),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildKeypadAction({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return _PressableScale(
      onTap: onTap,
      child: Container(
        height: 64,
        width: Get.width * 0.25,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF6B7280), size: 24),
      ),
    );
  }
}

class _FullCardDetailsPopup extends StatefulWidget {
  const _FullCardDetailsPopup();

  @override
  State<_FullCardDetailsPopup> createState() => _FullCardDetailsPopupState();
}

class _FullCardDetailsPopupState extends State<_FullCardDetailsPopup>
    with SingleTickerProviderStateMixin {
  bool _showCvv = false;
  late AnimationController _scaleCtrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _scaleAnim = CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeOutBack);
    _scaleCtrl.forward();
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  void _copyCardNumber() {
    Clipboard.setData(const ClipboardData(text: "1234 5678 9012 3456"));
    Get.rawSnackbar(
      message: "Card number copied",
      duration: const Duration(seconds: 2),
      backgroundColor: const Color(0xFF111111),
      borderRadius: 14,
      margin: const EdgeInsets.all(16),
      snackStyle: SnackStyle.FLOATING,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(color: Colors.black.withOpacity(0.45)),
            ),
          ),

          Center(
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        image: const DecorationImage(
                          image: AssetImage('assets/unioncardblack.webp'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFCC00).withOpacity(0.2),
                            blurRadius: 30,
                            offset: const Offset(0, 16),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/WU.png',
                                    height: 22,
                                    fit: BoxFit.contain,
                                  ),
                                  Image.asset(
                                    'assets/WHITE TRANSCORP .png',
                                    height: 14,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              Container(
                                width: 45,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFECB3),
                                      Color(0xFFE5C158),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "1234  5678  9012  3456",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _copyCardNumber,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.copy_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "CARD HOLDER",
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 10,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          GetStorage().read('name') ??
                                              "VINCE TALLENT",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        const Row(
                                          children: [
                                            Text(
                                              "VALID THRU  ",
                                              style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            Text(
                                              "12/28",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "CVV",
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 10,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      GestureDetector(
                                        onTap: () => setState(
                                          () => _showCvv = !_showCvv,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              _showCvv ? "123" : "•••",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Icon(
                                              _showCvv
                                                  ? Icons.visibility_rounded
                                                  : Icons
                                                        .visibility_off_rounded,
                                              color: Colors.white70,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    'assets/VisaFree.png',
                                    height: 18,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Text(
                          "Close",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PressableScale extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _PressableScale({required this.child, required this.onTap});

  @override
  State<_PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<_PressableScale> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}

class _AllCardsScreen extends StatelessWidget {
  const _AllCardsScreen();

  void _onCardTap(int index) {
    Get.bottomSheet(
      _MpinVerifySheet(
        onSuccess: () {
          Get.dialog(
            _CardDetailsPopup(card: _kCards[index]),
            barrierColor: Colors.transparent,
          );
        },
        title: 'Verify MPIN',
        subtitle: 'Enter MPIN to view card details',
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _borderColor, width: 1.5),
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: _textColor,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          'My Cards',
          style: TextStyle(
            color: _textColor,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _primaryRed.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _primaryRed.withOpacity(0.12)),
            ),
            child: Text(
              '${_kCards.length} Cards',
              style: const TextStyle(
                color: _primaryRed,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        itemCount: _kCards.length,
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final card = _kCards[index];
          final colors = card['colors'] as List<Color>;
          return _PressableScale(
            onTap: () => _onCardTap(index),
            child: Stack(
              children: [
                PremiumVisaCard(
                  cardNumber: card['fullNumber'] as String,
                  cardHolder:
                      GetStorage().read('name') ?? card['holder'] as String,
                  expiryDate: card['expiry'] as String,
                  cvv: "•••",
                  bgImage:
                      card['bgImage'] as String? ??
                      'assets/unioncardblack.webp',
                  useBlackLogos: card['useBlackLogos'] as bool? ?? false,
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.lock_outline_rounded,
                            color: Colors.white,
                            size: 13,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Tap to view',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CardDetailsPopup extends StatefulWidget {
  final Map<String, dynamic> card;
  const _CardDetailsPopup({required this.card});

  @override
  State<_CardDetailsPopup> createState() => _CardDetailsPopupState();
}

class _CardDetailsPopupState extends State<_CardDetailsPopup>
    with SingleTickerProviderStateMixin {
  bool _showCvv = false;
  late AnimationController _scaleCtrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _scaleAnim = CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeOutBack);
    _scaleCtrl.forward();
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  void _copyNumber() {
    Clipboard.setData(ClipboardData(text: widget.card['fullNumber'] as String));
    Get.rawSnackbar(
      message: 'Card number copied',
      duration: const Duration(seconds: 2),
      backgroundColor: const Color(0xFF111111),
      borderRadius: 14,
      margin: const EdgeInsets.all(16),
      snackStyle: SnackStyle.FLOATING,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.card['colors'] as List<Color>;
    final useBlackLogos = widget.card['useBlackLogos'] as bool? ?? false;
    final textColor = useBlackLogos ? Colors.black : Colors.white;
    final subColor = useBlackLogos ? Colors.black54 : Colors.white70;
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(color: Colors.black.withOpacity(0.45)),
            ),
          ),
          Center(
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        gradient: widget.card['bgImage'] != null
                            ? null
                            : LinearGradient(
                                colors: colors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        image: widget.card['bgImage'] != null
                            ? DecorationImage(
                                image: AssetImage(
                                  widget.card['bgImage'] as String,
                                ),
                                fit: BoxFit.cover,
                              )
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color:
                                (widget.card['bgImage'] != null
                                        ? const Color(0xFFFFCC00)
                                        : colors[1])
                                    .withOpacity(0.3),
                            blurRadius: 32,
                            offset: const Offset(0, 16),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          if (widget.card['bgImage'] == null) ...[
                            Positioned(
                              top: -30,
                              right: -30,
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.08),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -40,
                              left: -40,
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.08),
                                ),
                              ),
                            ),
                          ],
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/WU.png',
                                    height: 22,
                                    fit: BoxFit.contain,
                                    color: useBlackLogos ? Colors.black : null,
                                  ),
                                  Image.asset(
                                    'assets/WHITE TRANSCORP .png',
                                    height: 14,
                                    fit: BoxFit.contain,
                                    color: useBlackLogos ? Colors.black : null,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: 45,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFECB3),
                                      Color(0xFFE5C158),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.card['fullNumber'] as String,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 18,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _copyNumber,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: textColor.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.copy_rounded,
                                        color: textColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          GetStorage().read('name') ??
                                              widget.card['holder'] as String,
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Row(
                                          children: [
                                            Text(
                                              "VALID\nTHRU   ",
                                              style: TextStyle(
                                                color: subColor,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            Text(
                                              widget.card['expiry'] as String,
                                              style: TextStyle(
                                                color: textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'CVV',
                                          style: TextStyle(
                                            color: subColor,
                                            fontSize: 10,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        GestureDetector(
                                          onTap: () => setState(
                                            () => _showCvv = !_showCvv,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                _showCvv
                                                    ? widget.card['cvv']
                                                          as String
                                                    : '•••',
                                                style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Icon(
                                                _showCvv
                                                    ? Icons.visibility_rounded
                                                    : Icons
                                                          .visibility_off_rounded,
                                                color: subColor,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/VisaFree.png',
                                        height: 18,
                                        fit: BoxFit.contain,
                                        color: useBlackLogos
                                            ? Colors.black
                                            : null,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PayBillScreen extends StatelessWidget {
  const _PayBillScreen();

  static const _billers = [
    {
      'icon': Icons.bolt_rounded,
      'label': 'Electricity',
      'color': Color(0xFFFFA726),
      'sub': 'Pay your electricity bill',
    },
    {
      'icon': Icons.credit_card,
      'label': 'Credit Card Bill',
      'color': Color.fromARGB(255, 38, 110, 255),
      'sub': 'Pay your card bill',
    },
    {
      'icon': Icons.phone_android_rounded,
      'label': 'Mobile',
      'color': Color(0xFF42A5F5),
      'sub': 'Recharge or pay postpaid',
    },
    {
      'icon': Icons.tv_rounded,
      'label': 'DTH',
      'color': Color(0xFF7E57C2),
      'sub': 'Recharge your DTH',
    },
    {
      'icon': Icons.water_drop_rounded,
      'label': 'Water',
      'color': Color(0xFF26C6DA),
      'sub': 'Pay water utility bill',
    },
    {
      'icon': Icons.local_gas_station_rounded,
      'label': 'Gas',
      'color': Color(0xFF66BB6A),
      'sub': 'Pay gas pipeline bill',
    },
    {
      'icon': Icons.wifi_rounded,
      'label': 'Broadband',
      'color': Color(0xFFEF5350),
      'sub': 'Pay internet bill',
    },
    {
      'icon': Icons.toll_rounded,
      'label': 'Fastag',
      'color': Color(0xFF26A69A),
      'sub': 'Recharge your Fastag',
    },
    {
      'icon': Icons.account_balance_rounded,
      'label': 'Loan/EMI Payments',
      'color': Color(0xFF8D6E63),
      'sub': 'Pay your loan EMI',
    },
    {
      'icon': Icons.local_hospital_rounded,
      'label': 'Insurance',
      'color': Color(0xFFEC407A),
      'sub': 'Pay insurance premium',
    },
  ];

  void _showComingSoon(BuildContext context, String label) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: _primaryRed.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.hourglass_empty_rounded,
                color: _primaryRed,
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$label Coming Soon',
              style: const TextStyle(
                color: _textColor,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'We are working hard to bring this feature very soon. Stay tuned!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _secondaryText,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _textColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Got it',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFECECEC), width: 1.5),
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: _textColor,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          'Pay Bills',
          style: TextStyle(
            color: _textColor,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _primaryRed.withOpacity(0.07),
                    _primaryRed.withOpacity(0.02),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _primaryRed.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _primaryRed.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.receipt_long_rounded,
                      color: _primaryRed,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick & Secure Payments',
                        style: TextStyle(
                          color: _textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Pay all your bills in one place',
                        style: TextStyle(color: _secondaryText, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select a Category',
              style: TextStyle(
                color: _textColor,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.42,
                ),
                itemCount: _billers.length,
                itemBuilder: (context, index) {
                  final b = _billers[index];
                  final color = b['color'] as Color;
                  return _PressableScale(
                    onTap: () => _showComingSoon(context, b['label'] as String),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: color.withOpacity(0.18),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              b['icon'] as IconData,
                              color: color,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  b['label'] as String,
                                  style: const TextStyle(
                                    color: _textColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  b['sub'] as String,
                                  style: const TextStyle(
                                    color: _secondaryText,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BezierChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _primaryRed
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.2, size.height * 0.55),
      Offset(size.width * 0.4, size.height * 0.8),
      Offset(size.width * 0.6, size.height * 0.4),
      Offset(size.width * 0.8, size.height * 0.65),
      Offset(size.width, size.height * 0.2),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    fillPath.moveTo(points[0].dx, size.height);
    fillPath.lineTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
      final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);

      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );

      fillPath.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    const gradient = LinearGradient(
      colors: [Color(0x28FFCC00), Color(0x00FFCC00)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    fillPaint.shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    final peakPoint = points[5];
    final dotPaint = Paint()
      ..color = _primaryRed
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(peakPoint, 6, dotPaint);
    canvas.drawCircle(peakPoint, 6, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ServicesMoreScreen extends StatelessWidget {
  const ServicesMoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = (screenWidth - 40 - 16) / 2;
    final double dynamicAspectRatio = itemWidth / 130;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: const Color(0xFFECECEC), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: _textColor,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          'More Services',
          style: TextStyle(
            color: _textColor,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // Ambient light blobs in background
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFCC00).withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _primaryRed.withOpacity(0.04),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Financial Hub',
                  style: TextStyle(
                    color: _textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.6,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Select from our premium range of wallet operations.',
                  style: TextStyle(
                    color: _secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 28),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: dynamicAspectRatio,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildServiceCard(
                        icon: Icons.send_rounded,
                        title: 'Send Money',
                        subtitle: 'Instant transfer to bank / wallet',
                        color: const Color(0xFF00C853),
                        onTap: () => Get.toNamed("/sendmoney"),
                      ),
                      _buildServiceCard(
                        icon: Icons.add_rounded,
                        title: 'Add Money',
                        subtitle: 'Top-up wallet via UPI / Card',
                        color: const Color(0xFF2979FF),
                        onTap: () {
                          Get.bottomSheet(
                            const AddmoneyView(showGeneralWalletOption: false),
                            isScrollControlled: true,
                            isDismissible: false,
                            enableDrag: false,
                            backgroundColor: Colors.transparent,
                          );
                        },
                      ),
                      _buildServiceCard(
                        icon: Icons.receipt_long_rounded,
                        title: 'Pay Bill',
                        subtitle: 'Quick utility payments',
                        color: const Color(0xFFFF9100),
                        onTap: () => Get.to(
                          () => const _PayBillScreen(),
                          transition: Transition.cupertino,
                        ),
                      ),
                      _buildServiceCard(
                        icon: Icons.credit_card_rounded,
                        title: 'Forex Card',
                        subtitle: 'Multi-currency travel card',
                        color: const Color(0xFF651FFF),
                        isUpcoming: true,
                        onTap: () {},
                      ),
                      _buildServiceCard(
                        icon: Icons.swap_horizontal_circle_rounded,
                        title: 'Remittance',
                        subtitle: 'International money exchange',
                        color: const Color(0xFF00B0FF),
                        onTap: () => _openRemittanceBottomSheet(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    bool isUpcoming = false,
  }) {
    return _PressableScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isUpcoming
                ? const Color(0xFFECECEC)
                : color.withOpacity(0.12),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isUpcoming
                  ? Colors.black.withOpacity(0.02)
                  : color.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isUpcoming
                        ? const Color(0xFFF0F0F2)
                        : color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: isUpcoming ? Colors.grey[500] : color,
                    size: 20,
                  ),
                ),
                if (isUpcoming)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'SOON',
                      style: TextStyle(
                        color: Color(0xFFC62828),
                        fontSize: 7,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isUpcoming ? Colors.grey[600] : _textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isUpcoming ? Colors.grey[400] : _secondaryText,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isUpcoming = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isUpcoming ? const Color(0xFFF9F9FB) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isUpcoming
                ? const Color(0xFFECECEC)
                : _primaryRed.withOpacity(0.12),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUpcoming
                    ? const Color(0xFFF0F0F2)
                    : _primaryRed.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: isUpcoming ? Colors.grey[500] : _primaryRed,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isUpcoming ? Colors.grey[600] : _textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: isUpcoming ? Colors.grey[400] : _secondaryText,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (!isUpcoming)
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: _secondaryText,
                size: 14,
              ),
          ],
        ),
      ),
    );
  }

  void _openRemittanceBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Remittance',
              style: TextStyle(
                color: _textColor,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Select a remittance option',
              style: TextStyle(color: _secondaryText, fontSize: 14),
            ),
            const SizedBox(height: 24),
            _buildBottomSheetItem(
              icon: Icons.send_rounded,
              title: 'Send Money (Upcoming)',
              subtitle: 'Send money to bank account or wallet',
              isUpcoming: true,
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _buildBottomSheetItem(
              icon: Icons.call_received_rounded,
              title: 'Receive Money (Upcoming)',
              subtitle: 'Receive money directly into your account',
              isUpcoming: true,
              onTap: () {},
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
