import 'dart:math' as math;
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Onboarding%20Screen/onboardingscreen_controller.dart';

class OnboardingscreenView extends GetView<OnboardingscreenController> {
  const OnboardingscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OnboardingscreenController());

    const Color primaryRed = Color(0xFFE53935);
    const Color textColor = Color(0xFF111111);
    const Color secondaryText = Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Background page view for swipeable illustrations and text
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildPage1(context),
              _buildPage2(context),
              _buildPage3(context),
            ],
          ),

          // 2. Persistent Top Header (Skip Button with premium styling)
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 20,
            child: Obx(() {
              // Only show Skip button if we're not on the last page
              if (controller.currentPage.value == 2) {
                return const SizedBox.shrink();
              }
              return _PressableScale(
                onTap: controller.goToWelcome,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFECECEC),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: secondaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            }),
          ),

          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 24,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 56,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Obx(() {
                      final bool showBack = controller.currentPage.value > 0;
                      if (!showBack) return const SizedBox.shrink();
                      return _PressableScale(
                        onTap: () {
                          controller.pageController.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOutCubic,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFECECEC),
                              width: 1.2,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back_rounded,
                                size: 16,
                                color: secondaryText,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Back",
                                style: TextStyle(
                                  color: secondaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),

                  // Center: Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Obx(() {
                        final bool isActive =
                            controller.currentPage.value == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 6 : 6,
                          height: isActive ? 16 : 6,
                          decoration: BoxDecoration(
                            color: isActive
                                ? primaryRed
                                : const Color(0xFFE5E7EB),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        );
                      }),
                    ),
                  ),

                  // Right: Next / Get Started Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: _PressableScale(
                      onTap: controller.nextPage,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [primaryRed, Color(0xFFC62828)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: primaryRed.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() {
                              final bool isLastPage =
                                  controller.currentPage.value == 2;
                              return Text(
                                isLastPage ? "Get Started" : "Next",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              );
                            }),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Wave Background with Double Layer for Depth ---
  Widget _buildIllustrationBackground(Widget child) {
    return SizedBox(
      height: 410,
      child: Stack(
        children: [
          // Layer 1: Back Wave (lighter opacity, shifted slightly)
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(-10, 8),
              child: Transform.scale(
                scale: 1.02,
                child: ClipPath(
                  clipper: OnboardingBackgroundClipper(),
                  child: Container(
                    color: const Color(0xFFFFE4E6).withOpacity(0.55),
                  ),
                ),
              ),
            ),
          ),

          // Layer 2: Front Wave (vibrant gradient)
          Positioned.fill(
            child: ClipPath(
              clipper: OnboardingBackgroundClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFF0F2), Color(0xFFFFCCD5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),

          // Breathing Pulsing Sparkles / Stars
          const Positioned(top: 100, right: 40, child: PulsingStar(size: 20)),
          const Positioned(top: 160, left: 50, child: PulsingStar(size: 16)),
          const Positioned(bottom: 140, left: 30, child: PulsingStar(size: 14)),
          const Positioned(
            bottom: 90,
            right: 180,
            child: PulsingStar(size: 12),
          ),
          const Positioned(
            bottom: 160,
            right: 30,
            child: PulsingStar(size: 18),
          ),

          // The Illustration itself
          child,
        ],
      ),
    );
  }

  // --- Page 1: Simplified Card Management ---
  Widget _buildPage1(BuildContext context) {
    const Color textColor = Color(0xFF111111);
    const Color secondaryText = Color(0xFF6B7280);

    return Column(
      children: [
        _buildIllustrationBackground(
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: SizedBox(
                width: 280,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // 1. Back Card (Frosted Glass Card)
                    Transform.translate(
                      offset: const Offset(-28, -22),
                      child: Transform.rotate(
                        angle: -0.06,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Container(
                              width: 200,
                              height: 125,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.55),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.65),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 7,
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF3B82F6,
                                          ).withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(
                                            3.5,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.wifi_rounded,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: 26,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 110,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // 2. Front Card (Premium Glowing Purple Card)
                    Transform.translate(
                      offset: const Offset(15, 12),
                      child: Transform.rotate(
                        angle: -0.09,
                        child: Container(
                          width: 215,
                          height: 132,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF5B3FF2),
                                Color(0xFF7C3AED),
                                Color(0xFF8B5CF6),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF5B3FF2,
                                ).withOpacity(0.38),
                                blurRadius: 24,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              // Reflective Shine Line Overlay
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.12),
                                        Colors.white.withOpacity(0),
                                        Colors.white.withOpacity(0.06),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: const [0.0, 0.4, 0.8],
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Golden Chip representation
                                      Container(
                                        width: 30,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFFFFD54F),
                                              Color(0xFFFFA000),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(3),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 5,
                                                  height: 4,
                                                  color: Colors.black12,
                                                ),
                                                Container(
                                                  width: 5,
                                                  height: 4,
                                                  color: Colors.black12,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 18,
                                              height: 2,
                                              color: Colors.black12,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 5,
                                                  height: 4,
                                                  color: Colors.black12,
                                                ),
                                                Container(
                                                  width: 5,
                                                  height: 4,
                                                  color: Colors.black12,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Mastercard overlapping circles
                                      Stack(
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 18,
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(
                                                0.85,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 11,
                                            ),
                                            child: Container(
                                              width: 18,
                                              height: 18,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(
                                                  0.35,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  // Card number representation (dashes)
                                  Row(
                                    children: List.generate(4, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 12,
                                        ),
                                        child: Container(
                                          width: 26,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                              0.8,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              2,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Text Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Text(
                  "Simplified card\nmanagement",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Securely store and manage all your cards and keep track of your spends. Enjoy instant access whenever you need it, without the clutter of a physical wallet.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Page 2: Payments made easy & secure ---
  Widget _buildPage2(BuildContext context) {
    const Color textColor = Color(0xFF111111);
    const Color secondaryText = Color(0xFF6B7280);

    return Column(
      children: [
        _buildIllustrationBackground(
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 110),
              child: SizedBox(
                width: 280,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Card with Gradient & Premium elements
                    Positioned(
                      bottom: 10,
                      child: Container(
                        width: 215,
                        height: 130,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF8B5CF6), // Purple
                              Color(0xFFD946EF), // Magenta
                              Color(0xFFEC4899), // Pink
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.25),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFEC4899).withOpacity(0.35),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Reflection Gloss Overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.12),
                                      Colors.white.withOpacity(0),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                            ),
                            // Magnetic strip
                            Positioned(
                              top: 30,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 16,
                                color: const Color(
                                  0xFF1E3A8A,
                                ).withOpacity(0.85), // dark blue strip
                              ),
                            ),
                            // Two small bottom left stripes
                            Positioned(
                              bottom: 24,
                              left: 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 45,
                                    height: 3,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: 30,
                                    height: 3,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ],
                              ),
                            ),
                            // Bottom right pill
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: Container(
                                width: 40,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.95),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Padlock Overlaying Top Center
                    const Positioned(top: 5, child: LockWidget()),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Text Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Text(
                  "Payments made easy &\nsecure",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Say goodbye to complicated checkouts! With a tap, pay for anything effortlessly—online or in-store. Experience faster, safer, and stress-free transactions.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Page 3: Unlock exclusive rewards ---
  Widget _buildPage3(BuildContext context) {
    const Color textColor = Color(0xFF111111);
    const Color secondaryText = Color(0xFF6B7280);

    return Column(
      children: [
        _buildIllustrationBackground(
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: ParachuteGiftWidget(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Text Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Text(
                  "Unlock exclusive\nrewards",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Earn rewards every time you pay. Enjoy exciting cashback offers, loyalty points, and exclusive deals. Turn everyday spending into extraordinary savings.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// --- Lock Widget (Page 2) with Glassmorphic 3D styling ---
class LockWidget extends StatelessWidget {
  const LockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      height: 96,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Shackle (U-shaped metallic loop)
          Positioned(
            top: 2,
            child: Container(
              width: 44,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
                border: Border.all(
                  color: const Color(0xFF1E3A8A), // Steel blue
                  width: 7,
                ),
              ),
            ),
          ),
          // Lock Body with Glossy Highlights
          Positioned(
            bottom: 4,
            child: Container(
              width: 70,
              height: 58,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFA036),
                    Color(0xFFF97316),
                    Color(0xFFEA580C),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF97316).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Light Gloss Reflection
                  Positioned(
                    top: 2,
                    left: 2,
                    right: 2,
                    child: Container(
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.22),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: CustomPaint(
                      size: const Size(14, 22),
                      painter: KeyholePainter(const Color(0xFF1E3A8A)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KeyholePainter extends CustomPainter {
  final Color color;
  KeyholePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height * 0.3),
          radius: size.width / 2.2,
        ),
      )
      ..moveTo(size.width * 0.35, size.height * 0.5)
      ..lineTo(size.width * 0.1, size.height)
      ..lineTo(size.width * 0.9, size.height)
      ..lineTo(size.width * 0.65, size.height * 0.5)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// --- Parachute + Gift Widget (Page 3) with 3D details ---
class ParachuteGiftWidget extends StatelessWidget {
  const ParachuteGiftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Parachute Canopy and Strings
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 185,
            child: CustomPaint(painter: ParachutePainter()),
          ),
          // Gift Box hanging at the bottom
          Positioned(bottom: 5, child: const GiftBoxWidget()),
        ],
      ),
    );
  }
}

class ParachutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double canopyH = h * 0.44;

    // Draw the strings first (delicate rose-colored lines)
    final stringPaint = Paint()
      ..color = const Color(0xFFFF9CA6).withOpacity(0.68)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final Offset boxL = Offset(w / 2 - 28, h * 0.88);
    final Offset boxR = Offset(w / 2 + 28, h * 0.88);

    final int stringCount = 6;
    for (int i = 0; i < stringCount; i++) {
      double pct = i / (stringCount - 1);
      double x = w * 0.15 + (w * 0.7) * pct;
      double y = canopyH + math.sin(pct * math.pi) * 8;
      canvas.drawLine(Offset(x, y), boxL, stringPaint);
      canvas.drawLine(Offset(x, y), boxR, stringPaint);
    }

    // Draw the canopy stripes with detailed gradients
    final paint = Paint()..style = PaintingStyle.fill;
    final colors = [
      [const Color(0xFFF97316), const Color(0xFFEA580C)], // Orange
      [const Color(0xFFF472B6), const Color(0xFFDB2777)], // Pink
      [const Color(0xFF8B5CF6), const Color(0xFF6D28D9)], // Purple
      [const Color(0xFFC084FC), const Color(0xFFA855F7)], // Violet
      [const Color(0xFFF472B6), const Color(0xFFDB2777)], // Pink
      [const Color(0xFFF97316), const Color(0xFFEA580C)], // Orange
    ];

    final double startX = w * 0.12;
    final double endX = w * 0.88;
    final double canopyW = endX - startX;

    for (int i = 0; i < colors.length; i++) {
      final double x1 = startX + canopyW * (i / colors.length);
      final double x2 = startX + canopyW * ((i + 1) / colors.length);

      // Setup LinearGradient for 3D curved lighting effect on each segment
      paint.shader = LinearGradient(
        colors: colors[i],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTRB(x1, 22, x2, canopyH + 14));

      final path = Path();
      path.moveTo(x1, canopyH + math.sin((i / colors.length) * math.pi) * 6);

      const double topY = 22;
      final double midX1 = x1 + (x2 - x1) / 2;
      path.quadraticBezierTo(
        x1 + (w / 2 - x1) * 0.4,
        topY + (canopyH - topY) * 0.05,
        w / 2 + (midX1 - w / 2) * 0.9,
        topY,
      );
      path.quadraticBezierTo(
        x2 + (w / 2 - x2) * 0.4,
        topY + (canopyH - topY) * 0.05,
        x2,
        canopyH + math.sin(((i + 1) / colors.length) * math.pi) * 6,
      );

      path.quadraticBezierTo(
        (x1 + x2) / 2,
        canopyH + math.sin(((i + 0.5) / colors.length) * math.pi) * 14,
        x1,
        canopyH + math.sin((i / colors.length) * math.pi) * 6,
      );

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GiftBoxWidget extends StatelessWidget {
  const GiftBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 72,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // 1. Gift Box Main Body (Gradients and borders)
          Positioned(
            bottom: 2,
            child: Container(
              width: 58,
              height: 46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFB35C),
                    Color(0xFFFFA036),
                    Color(0xFFFF890A),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),

          // 2. Gift Box Lid (overlays body, giving it realistic 3D appearance)
          Positioned(
            bottom: 42,
            child: Container(
              width: 64,
              height: 12,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFCA85), Color(0xFFFFB35C)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),

          // 3. Horizontal Ribbon line
          Positioned(
            bottom: 20,
            child: Container(
              width: 58,
              height: 10,
              color: const Color(0xFF1E3A8A), // Dark Blue ribbon
            ),
          ),

          // 4. Vertical Ribbon line
          Positioned(
            bottom: 2,
            child: Container(
              width: 10,
              height: 52,
              color: const Color(0xFF1E3A8A), // Dark Blue ribbon
            ),
          ),

          // 5. Bow Ribbon Loops floating on top
          Positioned(
            top: -6,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Left loop
                Transform.rotate(
                  angle: -0.35,
                  child: Container(
                    width: 25,
                    height: 16,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF1E3A8A),
                        width: 4.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                // Right loop
                Transform.rotate(
                  angle: 0.35,
                  child: Container(
                    width: 25,
                    height: 16,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF1E3A8A),
                        width: 4.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Custom Clipper for Wavy Gradient Top Background ---
class OnboardingBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.74);

    // Dynamic wave curves matching the screenshots
    final firstControlPoint = Offset(size.width * 0.35, size.height * 0.86);
    final firstEndPoint = Offset(size.width * 0.62, size.height * 0.70);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.85, size.height * 0.56);
    final secondEndPoint = Offset(size.width, size.height * 0.66);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// 4-Point Star Painter
class StarPainter extends CustomPainter {
  final Color color;
  StarPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..quadraticBezierTo(
        size.width / 2,
        size.height / 2,
        size.width,
        size.height / 2,
      )
      ..quadraticBezierTo(
        size.width / 2,
        size.height / 2,
        size.width / 2,
        size.height,
      )
      ..quadraticBezierTo(size.width / 2, size.height / 2, 0, size.height / 2)
      ..quadraticBezierTo(size.width / 2, size.height / 2, size.width / 2, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Stateful Pulsing Star Widget for Breathing Micro-Animation
class PulsingStar extends StatefulWidget {
  final double size;
  final Color color;
  const PulsingStar({
    super.key,
    this.size = 24,
    this.color = const Color(0xFFFF4E64),
  });

  @override
  State<PulsingStar> createState() => _PulsingStarState();
}

class _PulsingStarState extends State<PulsingStar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Random stagger start delay so stars don't pulse at the exact same millisecond
    final double delayFactor = math.Random().nextDouble();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1400 + (delayFactor * 1000).toInt()),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.72,
      end: 1.28,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(Duration(milliseconds: (delayFactor * 500).toInt()), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: StarPainter(widget.color),
      ),
    );
  }
}

// --- PressableScale Widget for Premium Click Feedback ---
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
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}
