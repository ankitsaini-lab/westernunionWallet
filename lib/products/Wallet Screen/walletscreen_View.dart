import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Wallet%20Screen/walletscreen_Controller.dart';
import 'package:transwallet/widgets/globalbottombar/Globalbottombar_View.dart';
import 'package:transwallet/products/Wallet%20Screen/Add%20Money/addmoney_View.dart';

class WalletscreenView extends GetView<WalletscreenController> {
  const WalletscreenView({super.key});

  static const Color primaryRed = Color(0xFFFFCC00);
  static const Color secondaryRed = Color(0xFFFFB300);
  static const Color textColor = Color(0xFF111111);
  static const Color secondaryText = Color(0xFF6B7280);
  static const Color borderColor = Color(0xFFECECEC);
  static const Color backgroundColor = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<WalletscreenController>()) {
      Get.lazyPut(() => WalletscreenController());
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: GlobalbottombarView(seletedIndex: 1.obs),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),

                _animateWidget(delayIndex: 0, child: _buildHeader()),
                const SizedBox(height: 15),
                _animateWidget(
                  delayIndex: 1,
                  child: Obx(() {
                    if (controller.wallets.isEmpty) return const SizedBox();
                    return _PrimaryGeneralWalletCard(
                      wallet: controller.wallets[0],
                    );
                  }),
                ),
                const SizedBox(height: 36),

                
                _animateWidget(delayIndex: 2, child: _buildOtherWallets()),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Digital Wallet",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w800,
              fontSize: 24,
              letterSpacing: -0.5,
            ),
          ),
          Obx(() {
            final isRevealed = controller.isBalanceRevealed.value;
            return GestureDetector(
              onTap: () {
                if (isRevealed) {
                  controller.hideBalance();
                } else {
                  Get.bottomSheet(
                    _MpinVerifySheet(
                      onSuccess: () => controller.revealBalance(),
                      title: "Enter MPIN to View Balance",
                      subtitle: "For your security, enter your 4-digit mobile PIN",
                    ),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: primaryRed.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: primaryRed.withOpacity(0.12)),
                ),
                child: Row(
                  children: [
                    Icon(
                      isRevealed ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                      color: Color(0xFF111111),
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isRevealed ? "Hide Balances" : "Show Balances",
                      style: const TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOtherWallets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "Other Wallets",
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: primaryRed.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Top up using General Wallet",
                style: TextStyle(
                  color: primaryRed,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Obx(() {
          final _ = controller
              .expandedIndex
              .value; 
          if (controller.wallets.length <= 1) return const SizedBox();

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.wallets.length - 1,
            itemBuilder: (context, i) {
              final int actualIndex = i + 1;
              final wallet = controller.wallets[actualIndex];
              final isExpanded = controller.expandedIndex.value == actualIndex;

              return GestureDetector(
                onTap: () => controller.expandedIndex.value = isExpanded
                    ? -1
                    : actualIndex,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: borderColor, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: primaryRed.withOpacity(0.1),
                                width: 1,
                              ),
                              image: DecorationImage(
                                image: AssetImage(wallet["icon"].toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  wallet["title"].toString(),
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  "Available Balance",
                                  style: TextStyle(
                                    color: secondaryText,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (controller.isBalanceRevealed.value) {
                                controller.hideBalance();
                              } else {
                                Get.bottomSheet(
                                  _MpinVerifySheet(
                                    onSuccess: () => controller.revealBalance(),
                                    title: "Enter MPIN to View Balance",
                                    subtitle: "For your security, enter your 4-digit mobile PIN",
                                  ),
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                );
                              }
                            },
                            child: Obx(() {
                              final isRevealed = controller.isBalanceRevealed.value;
                              return AnimatedCrossFade(
                                firstChild: const Text(
                                  "₹ ••••",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                secondChild: Text(
                                  "₹${wallet["balance"]}",
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                crossFadeState: isRevealed
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 250),
                              );
                            }),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: secondaryText,
                            size: 20,
                          ),
                        ],
                      ),
                      if (isExpanded) ...[
                        const SizedBox(height: 20),
                        const Divider(
                          color: borderColor,
                          height: 1,
                          thickness: 1,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildSubWalletActionButton(
                              "Top-up",
                              Icons.account_balance_wallet_rounded,
                              onTap: () {
                                Get.bottomSheet(
                                  const AddmoneyView(showGeneralWalletOption: true),
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  enableDrag: false,
                                  backgroundColor: Colors.transparent,
                                );
                              },
                            ),
                            const SizedBox(width: 12),
                            _buildSubWalletActionButton(
                              "Transactions",
                              Icons.history_rounded,
                              onTap: () {
                                Get.toNamed(
                                  "/walletdetails",
                                  arguments: {"data": wallet},
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildSubWalletActionButton(
    String text,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: _PressableScale(
        onTap: onTap ?? () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFCC00).withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFFCC00).withOpacity(0.3)),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFF111111), size: 16),
              const SizedBox(width: 6),
              Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
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

class _PrimaryGeneralWalletCard extends StatefulWidget {
  final Map wallet;
  const _PrimaryGeneralWalletCard({required this.wallet});

  @override
  State<_PrimaryGeneralWalletCard> createState() =>
      _PrimaryGeneralWalletCardState();
}

class _PrimaryGeneralWalletCardState extends State<_PrimaryGeneralWalletCard> {
  final _controller = Get.find<WalletscreenController>();

  void _toggleBalance() {
    if (_controller.isBalanceRevealed.value) {
      _controller.hideBalance();
    } else {
      _showMpinSheet();
    }
  }

  void _reveal() {
    _controller.revealBalance();
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

  @override
  Widget build(BuildContext context) {
    const Color primaryRed = Color(0xFFFFCC00);
    const Color textColor = Color(0xFF111111);
    const Color secondaryText = Color(0xFF6B7280);
    const Color borderColor = Color(0xFFECECEC);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [
            Colors.white,
            Color(0xFFFFFDF0), 
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: primaryRed.withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        children: [
          
          Positioned(
            right: -25,
            top: -25,
            child: Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryRed.withOpacity(0.03),
              ),
            ),
          ),
          Positioned(
            left: -35,
            bottom: -35,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.015),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primaryRed.withOpacity(0.1),
                              width: 1,
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                widget.wallet["icon"].toString(),
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
                              widget.wallet["title"].toString(),
                              style: const TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const Text(
                              "Wallet ID: GW-1045",
                              style: TextStyle(
                                color: secondaryText,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: primaryRed.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryRed.withOpacity(0.3)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.star_rounded, color: Color(0xFF111111), size: 12),
                          SizedBox(width: 4),
                          Text(
                            "Primary",
                            style: TextStyle(
                              color: Color(0xFF111111),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                const Text(
                  "Available Balance",
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Obx(() {
                  final isRevealed = _controller.isBalanceRevealed.value;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _toggleBalance,
                        behavior: HitTestBehavior.opaque,
                        child: AnimatedCrossFade(
                          firstChild: const Text(
                            "₹ ••••••",
                            style: TextStyle(
                              color: textColor,
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                          secondChild: Text(
                            "₹${widget.wallet["balance"]}",
                            style: const TextStyle(
                              color: textColor,
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.8,
                            ),
                          ),
                          crossFadeState: isRevealed
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 250),
                        ),
                      ),
                      GestureDetector(
                        onTap: _toggleBalance,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryRed.withOpacity(0.15),
                          ),
                          child: Icon(
                            isRevealed
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            color: const Color(0xFF111111),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 15),
                const Divider(color: borderColor, height: 1, thickness: 1),
                const SizedBox(height: 15),

                Row(
                  children: [
                    _buildCardAction(
                      "Add Money",
                      Icons.add_rounded,
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
                    const SizedBox(width: 12),
                    _buildCardAction(
                      "Transactions",
                      Icons.history,
                      onTap: () {
                        Get.toNamed(
                          "/walletdetails",
                          arguments: {"data": widget.wallet},
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardAction(String title, IconData icon, {VoidCallback? onTap}) {
    return Expanded(
      child: _PressableScale(
        onTap: onTap ?? () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: WalletscreenView.primaryRed.withOpacity(0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFF111111), size: 20),
              const SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(
                  color: WalletscreenView.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
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
    const Color primaryRed = Color(0xFFFFCC00);
    const Color textColor = Color(0xFF111111);
    const Color secondaryText = Color(0xFF6B7280);

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
              color: primaryRed.withOpacity(0.15),
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
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.subtitle,
            style: const TextStyle(color: secondaryText, fontSize: 13),
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
                      ? primaryRed.withOpacity(0.3)
                      : (isFilled ? primaryRed : const Color(0xFFECECEC)),
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
                valueColor: AlwaysStoppedAnimation<Color>(primaryRed),
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
                color: secondaryText,
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
        decoration: const BoxDecoration(
          color: Color(0xFFF9F9F9),
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
