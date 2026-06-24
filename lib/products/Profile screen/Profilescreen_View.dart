import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:transwallet/widgets/common_webview_screen.dart';
import 'package:transwallet/products/Profile%20screen/profilescreen_Controller.dart';
import 'package:transwallet/widgets/custombutton.dart';
import 'package:transwallet/utilities/getStorage.dart';

class ProfilescreenView extends GetView<ProfilescreenController> {
  const ProfilescreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfilescreenController());
    const Color primaryRed = Color(0xFFFFCC00);
    const Color textColor = Color(0xFF111111);
    const Color secondaryText = Color(0xFF6B7280);
    const Color borderColor = Color(0xFFECECEC);

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.80,
            minChildSize: 0.7,
            maxChildSize: 0.95,
            builder: (_, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                            ),
                            child: const SizedBox(
                              width: double.infinity,
                              height: 190,
                              child: _InteractiveMultiCardFan(),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                height: 5,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: -45,
                            left: 24,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  height: 94,
                                  width: 94,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 4,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.12),
                                        blurRadius: 16,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        "assets/360_F_244436923_vkMe10KKKiw5bjhZeRDT05moxWcPpdmb.jpg",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt_rounded,
                                      color: const Color(0xFF111111),
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      box.read('name') ?? "Jane Doe",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: textColor,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                    const SizedBox(width: 8),

                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFFCC00),
                                            Color(0xFFFFB300),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.verified_user_rounded,
                                            color: Color(0xFF111111),
                                            size: 10,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "ELITE",
                                            style: TextStyle(
                                              color: Color(0xFF111111),
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${(box.read('name') ?? 'jane').toString().toLowerCase().replaceAll(' ', '.')}@westernunion.com",
                                  style: TextStyle(
                                    color: secondaryText,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8, bottom: 8),
                              child: Text(
                                "CARDS & SECURITY",
                                style: TextStyle(
                                  color: secondaryText,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.02),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _buildCustomMenuItem(
                                    title: "Card Control",
                                    subtitle:
                                        "Manage transaction limits, card locks & PINs",
                                    iconPath: "assets/controller.svg",
                                    accentColor: Colors.deepPurple,
                                    onTap: () => Get.toNamed('/managecard'),
                                  ),
                                  const Divider(
                                    color: borderColor,
                                    height: 1,
                                    indent: 64,
                                  ),
                                  _buildCustomMenuItem(
                                    title: "Order New Card",
                                    subtitle:
                                        "Order a signature Obsidian credit card",
                                    iconPath:
                                        "assets/credit-card-svgrepo-com.svg",
                                    accentColor: primaryRed,
                                    onTap: () => Get.toNamed('/ordercard'),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            const Padding(
                              padding: EdgeInsets.only(left: 8, bottom: 8),
                              child: Text(
                                "ACCOUNT & SUPPORT",
                                style: TextStyle(
                                  color: secondaryText,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.02),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _buildCustomMenuItem(
                                    title: "Profile Details",
                                    subtitle:
                                        "Verify your email & account verification status",
                                    iconPath:
                                        "assets/profile-circle-svgrepo-com.svg",
                                    accentColor: Colors.blue,
                                    onTap: () => Get.toNamed('/profiledetails'),
                                  ),
                                  const Divider(
                                    color: borderColor,
                                    height: 1,
                                    indent: 64,
                                  ),
                                  _buildCustomMenuItem(
                                    title: "Contact Support",
                                    subtitle:
                                        "Create a support ticket or chat with an agent",
                                    iconPath: "assets/contectsupport.svg",
                                    accentColor: Colors.green,
                                    onTap: () => Get.toNamed('/contactsupport'),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            const Padding(
                              padding: EdgeInsets.only(left: 8, bottom: 8),
                              child: Text(
                                "LEGAL & ABOUT",
                                style: TextStyle(
                                  color: secondaryText,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.02),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _buildCustomMenuItem(
                                    title: "FAQs",
                                    subtitle:
                                        "Quick answers to common questions",
                                    iconPath: "assets/faq.svg",
                                    accentColor: Colors.teal,
                                    onTap: () {},
                                  ),
                                  const Divider(
                                    color: borderColor,
                                    height: 1,
                                    indent: 64,
                                  ),
                                  _buildCustomMenuItem(
                                    title: "Privacy Policy",
                                    subtitle:
                                        "Understand how we protect your wallet details",
                                    iconPath: "assets/privacycom.svg",
                                    accentColor: Colors.blueGrey,
                                    onTap: () {},
                                  ),
                                  const Divider(
                                    color: borderColor,
                                    height: 1,
                                    indent: 64,
                                  ),
                                  _buildCustomMenuItem(
                                    title: "Terms & Conditions",
                                    subtitle:
                                        "Read our prepaid service agreements",
                                    iconPath: "assets/condition&Terms.svg",
                                    accentColor: Colors.amber.shade800,
                                    onTap: () {
                                      Get.to(
                                        () => const CommonWebViewScreen(
                                          url:
                                              // "https://www.google.com",
                                              'https://transcorpint.com/app/termsAndConditions.html',
                                          title: 'Terms & Conditions',
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 36),

                            CustomButton(
                              text: "Sign Out",
                              prefixIcon: const Icon(
                                Icons.logout_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              btncolor: Colors.black,
                              onPressed: () =>
                                  controller.showLuxuryLogoutDialog(context),
                            ),

                            const SizedBox(height: 24),

                            const Center(
                              child: Text(
                                "App version 2.4.66 • Western Union Prepaid",
                                style: TextStyle(
                                  color: secondaryText,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 36),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomMenuItem({
    required String title,
    required String subtitle,
    required String iconPath,
    required Color accentColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor.withOpacity(0.08),
              ),
              child: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(accentColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF9CA3AF),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _InteractiveMultiCardFan extends StatefulWidget {
  const _InteractiveMultiCardFan();

  @override
  State<_InteractiveMultiCardFan> createState() =>
      _InteractiveMultiCardFanState();
}

class _InteractiveMultiCardFanState extends State<_InteractiveMultiCardFan>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;

  double _dragX = 0.0;
  double _dragY = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _breathingAnimation = CurvedAnimation(
      parent: _breathingController,
      curve: Curves.easeInOutSine,
    );
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _isDragging = true;

      _dragX = (_dragX + details.delta.dx * 0.005).clamp(-0.4, 0.4);
      _dragY = (_dragY + details.delta.dy * 0.005).clamp(-0.4, 0.4);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });

    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 16));
      if (_isDragging) return false;
      setState(() {
        _dragX *= 0.85;
        _dragY *= 0.85;
      });
      return _dragX.abs() > 0.001 || _dragY.abs() > 0.001;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      onPanCancel: () => _onPanEnd(DragEndDetails()),
      child: AnimatedBuilder(
        animation: _breathingAnimation,
        builder: (context, child) {
          final progress = _breathingAnimation.value;

          final leftBaseRot = -0.20 + (progress * 0.05);
          final rightBaseRot = 0.20 - (progress * 0.05);

          final leftRot = leftBaseRot + _dragX * 0.5;
          final rightRot = rightBaseRot + _dragX * 0.5;
          final centerRot = _dragX * 0.4;

          final leftOffset = -42.0 + (progress * 10) + (_dragX * 40.0);
          final rightOffset = 42.0 - (progress * 10) + (_dragX * 40.0);

          final centerOffsetY = -6.0 + (progress * 8) + (_dragY * 30.0);
          final centerOffsetX = _dragX * 25.0;

          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF070509), Color(0xFF14101A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),

              Positioned(
                left: -20 + (_dragX * 50),
                top: -30 + (_dragY * 30),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(
                      0xFFFFCC00,
                    ).withOpacity(0.09 + (progress * 0.04)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFCC00).withOpacity(0.12),
                        blurRadius: 50,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                right: -20 - (_dragX * 50),
                bottom: -30 - (_dragY * 30),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(
                      0xFF4CAF50,
                    ).withOpacity(0.07 + ((1 - progress) * 0.03)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4CAF50).withOpacity(0.10),
                        blurRadius: 60,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                ),
              ),

              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(-_dragY * 0.4)
                  ..rotateY(_dragX * 0.4),
                alignment: FractionalOffset.center,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Transform.translate(
                      offset: Offset(leftOffset, 12 + (_dragY * 15)),
                      child: Transform.rotate(
                        angle: leftRot,
                        child: _buildMiniPrepaidCard(
                          title: "WESTERN UNION",
                          subtitle: "OBSIDIAN ELITE",
                          colors: [
                            const Color(0xFFFFB300),
                            const Color(0xFFFFCC00),
                          ],
                          glowColor: const Color(0xFFFFCC00),
                          number: "•••• 4012",
                        ),
                      ),
                    ),

                    Transform.translate(
                      offset: Offset(rightOffset, 16 + (_dragY * 15)),
                      child: Transform.rotate(
                        angle: rightRot,
                        child: _buildMiniPrepaidCard(
                          title: "WESTERN UNION",
                          subtitle: "EMERALD NEON",
                          colors: [
                            const Color(0xFF0D533A),
                            const Color(0xFF00C853),
                          ],
                          glowColor: const Color(0xFF69F0AE),
                          number: "•••• 9012",
                        ),
                      ),
                    ),

                    Transform.translate(
                      offset: Offset(centerOffsetX, centerOffsetY),
                      child: Transform.rotate(
                        angle: centerRot,
                        child: _buildMiniPrepaidCard(
                          title: "WESTERN UNION",
                          subtitle: "GOLD SPARK",
                          colors: [
                            const Color(0xFF111111),
                            const Color(0xFF2C2C2C),
                          ],
                          glowColor: const Color(0xFFFFD54F),
                          number: "•••• 5678",
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 8,
                child: Opacity(
                  opacity: _isDragging ? 0.0 : 0.4,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.swipe_rounded,
                        color: Colors.white,
                        size: 10,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Swipe to tilt cards in 3D",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMiniPrepaidCard({
    required String title,
    required String subtitle,
    required List<Color> colors,
    required Color glowColor,
    required String number,
  }) {
    return Container(
      width: 170,
      height: 108,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.18),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/WU.png',
                      height: 10,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 10),
                    Container(width: 1, height: 16, color: Colors.white30),
                    const SizedBox(width: 10),
                    Image.asset(
                      'assets/WHITE TRANSCORP .png',
                      height: 6,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 12,
                width: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "PREPAID CARD",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                'assets/VisaFree.png',
                height: 10,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
