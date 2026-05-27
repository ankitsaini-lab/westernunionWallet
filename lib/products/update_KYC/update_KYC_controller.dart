import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/widgets/custombutton.dart';
import 'package:confetti/confetti.dart';

class UpdateKycController extends GetxController {
  var isConsentChecked = false.obs;
  var isFullKycStarted = false.obs;
  var selectedKycTier = "full".obs; // min, full

  // Redirection states
  var isRedirecting = false.obs;
  var redirectionStatus = "Initializing secure connection...".obs;
  var redirectionProgress = 0.0.obs;
  Timer? _redirectTimer;

  void toggleConsent(bool value) {
    isConsentChecked.value = value;
  }

  void proceedToFullKyc() {
    if (isConsentChecked.value) {
      isFullKycStarted.value = true;
    }
  }

  void startBrowserRedirection() {
    isRedirecting.value = true;
    redirectionProgress.value = 0.0;
    redirectionStatus.value = "Opening secure browser session...";

    _redirectTimer?.cancel();

    int elapsed = 0;
    _redirectTimer = Timer.periodic(const Duration(milliseconds: 1000), (
      timer,
    ) {
      elapsed++;
      redirectionProgress.value = (elapsed / 6) * 1.0;

      if (elapsed == 1) {
        redirectionStatus.value = "Launching secure KYC partner portal...";
      } else if (elapsed == 3) {
        redirectionStatus.value =
            "Awaiting verification completion on browser...";
      } else if (elapsed == 5) {
        redirectionStatus.value =
            "Biometric check & document signatures verified!";
      } else if (elapsed >= 6) {
        timer.cancel();
        isRedirecting.value = false;
        showKycSuccessPopup();
      }
    });
  }

  Widget updateKycView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subtitle from screenshot
                    const Text(
                      "Effortlessly verify your identity to enjoy uninterrupted access to everything we offer.",
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13,
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Beautiful Premium Platinum Card Preview representing ₹200,000 limit
                    _buildPlatinumCard(),

                    const SizedBox(height: 28),

                    // Heading from screenshot
                    const Text(
                      "Choose your KYC",
                      style: TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Premium Full KYC Card
                    _buildFullKycCard(),

                    const Spacer(),

                    // Sleek dynamic consent panel box
                    Obx(
                      () => Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Theme(
                              data: ThemeData(
                                unselectedWidgetColor: const Color(0xFF6B7280),
                              ),
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: Checkbox(
                                  value: isConsentChecked.value,
                                  activeColor: const Color(0xFFE53935),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  onChanged: (val) => toggleConsent(val!),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  toggleConsent(!isConsentChecked.value);
                                },
                                child: Text(
                                  "by checking this, you consent to share your aadhaar details and biometric checks for regulatory compliance.",
                                  style: TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 12,
                                    height: 1.4,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Proceed button from screenshot
                    Obx(
                      () => CustomButton(
                        text: "Proceed",
                        btncolor: isConsentChecked.value
                            ? Color(0xFFC62828)
                            : Colors.grey.shade300,
                        onPressed: () {
                          if (isConsentChecked.value) {
                            proceedToFullKyc();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlatinumCard() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF111111), Color(0xFFC62828), Color(0xFFE53935)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE53935).withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Elegant metallic grid accents / futuristic glowing light circles
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            left: -30,
            bottom: -30,
            child: Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.03),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "TransWallet Platinum",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    // Gold Metallic Holographic Chip representation
                    Container(
                      height: 28,
                      width: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFE082),
                            Color(0xFFFFB300),
                            Color(0xFFFFD54F),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "MAX LIMIT UNLOCKED",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "₹200,000",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "••••  ••••  ••••  2026",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.contactless_outlined,
                      color: Colors.white.withOpacity(0.6),
                      size: 20,
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

  Widget _buildFullKycCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE53935), width: 2.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE53935).withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Radio indicator custom-built and animated
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE53935), width: 2),
            ),
            padding: const EdgeInsets.all(3),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE53935),
              ),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Full KYC",
                  style: TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "The maximum wallet limit is ₹200,000",
                  style: TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Complete verification for unrestricted access to all features.",
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fullKycView() {
    return Obx(() {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE53935).withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified_user_rounded,
                        color: Color(0xFFE53935),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Identity Verification",
                            style: TextStyle(
                              color: Color(0xFF111111),
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.4,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Complete KYC to unlock full neobank features",
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                const Divider(color: Color(0xFFECECEC), height: 1),
                const SizedBox(height: 24),

                const Text(
                  "Required Steps for Verification",
                  style: TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildStaticStepCard(
                        stepNumber: "1",
                        title: "Upload PAN Card",
                        description:
                            "Scan your physical Permanent Account Number (PAN) Card clearly in high quality.",
                        icon: Icons.assignment_outlined,
                      ),
                      _buildStaticStepCard(
                        stepNumber: "2",
                        title: "Validate Aadhaar OTP",
                        description:
                            "Authenticate securely via OTP sent to UIDAI registered mobile number.",
                        icon: Icons.fingerprint_rounded,
                      ),
                      _buildStaticStepCard(
                        stepNumber: "3",
                        title: "Video Call Verification",
                        description:
                            "Quick check-in call with a secure TransWallet compliance officer.",
                        icon: Icons.videocam_outlined,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                CustomButton(
                  text: "Get Started",
                  btncolor: const Color(0xFFE53935),
                  onPressed: () {
                    startBrowserRedirection();
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Redirection loading overlay
          if (isRedirecting.value) _buildRedirectionOverlay(),
        ],
      );
    });
  }

  Widget _buildStaticStepCard({
    required String stepNumber,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFECECEC), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE53935).withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFE53935), size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECECEC),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "STEP 0$stepNumber",
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 8.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRedirectionOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.88),
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Padlock pulsing animation
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.85, end: 1.05),
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            builder: (context, val, child) {
              return Transform.scale(scale: val, child: child);
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE53935).withOpacity(0.15),
                border: Border.all(color: const Color(0xFFE53935), width: 2),
              ),
              child: const Icon(
                Icons.lock_outline_rounded,
                color: Color(0xFFE53935),
                size: 36,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            "SECURE REDIRECTION",
            style: TextStyle(
              color: Color(0xFFE53935),
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Redirecting to KYC Portal...",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            redirectionStatus.value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 36),

          // Progress bar indicators
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 200,
              height: 4,
              child: LinearProgressIndicator(
                value: redirectionProgress.value,
                backgroundColor: Colors.white10,
                color: const Color(0xFFE53935),
              ),
            ),
          ),

          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.security_rounded, color: Color(0xFF4CAF50), size: 14),
              SizedBox(width: 6),
              Text(
                "256-Bit SSL Secured Session",
                style: TextStyle(
                  color: Colors.white30,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  late ConfettiController confettiController = ConfettiController(
    duration: const Duration(seconds: 10),
  );

  void playAnimation() {
    confettiController.play();
  }

  @override
  void onClose() {
    _redirectTimer?.cancel();
    confettiController.dispose();
    super.onClose();
  }

  void showKycSuccessPopup() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: true,
                  numberOfParticles: 40,
                  emissionFrequency: 0.08,
                  maxBlastForce: 25,
                  minBlastForce: 10,
                  gravity: 0.2,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.orange,
                    Colors.purple,
                    Colors.red,
                    Colors.yellow,
                    Colors.pink,
                    Colors.cyan,
                    Colors.teal,
                    Colors.amber,
                    Colors.indigo,
                    Colors.lime,
                    Color(0xFF00E5FF),
                    Color(0xFFFF4081),
                    Color(0xFFFFD740),
                  ],
                ),
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified, color: Colors.green, size: 60),
                  const SizedBox(height: 10),

                  const Text(
                    "Congratulations 🎉",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Your Full KYC is Successfully Completed.\nYou can now enjoy all features!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),

                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Go to Dashboard",
                    btncolor: Colors.black,
                    onPressed: () {
                      Get.back();
                      Get.offAllNamed("/dashboard");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    playAnimation();
  }
}
