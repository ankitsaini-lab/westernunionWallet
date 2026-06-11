import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/minKYCScreen/minkycScreen_Controller.dart';
import 'package:transwallet/widgets/custombutton.dart';
import 'package:transwallet/widgets/upercasetextformatter.dart';

class MinkycscreenView extends GetView<MinkycscreenController> {
  const MinkycscreenView({super.key});

  static const _primaryRed = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MinkycscreenController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Min KYC',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_primaryRed, Color(0xFFFF6B6B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: _primaryRed.withOpacity(0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  
                  Positioned(
                    top: -20,
                    right: -20,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.07),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    left: -30,
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.06),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified_user_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'KYC Verification',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Verify your identity to unlock\nfull wallet features & benefits.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      Row(
                        children: [
                          _StepPill(label: '1  Details', done: true),
                          const SizedBox(width: 8),
                          _StepPill(label: '2  PAN', active: true),
                          const SizedBox(width: 8),
                          _StepPill(label: '3  Done'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            
            Row(
              children: [
                Expanded(
                  child: _InfoTile(
                    icon: Icons.security_rounded,
                    label: '256-bit\nEncrypted',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoTile(
                    icon: Icons.timer_rounded,
                    label: '2 Min\nProcess',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoTile(
                    icon: Icons.lock_rounded,
                    label: '100%\nSecure',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            
            const Text(
              'PAN Card Number',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 8),

            
            Obx(
              () => TextField(
                onChanged: controller.onPanChanged,
                style: const TextStyle(
                  letterSpacing: 3,
                  fontWeight: FontWeight.w600,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  UpperCaseTextFormatter(),
                ],
                decoration: InputDecoration(
                  hintText: 'ABCDE1234F',
                  hintStyle: const TextStyle(
                    letterSpacing: 2,
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.credit_card_rounded,
                    color: _primaryRed,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  errorText: controller.panError.value.isEmpty
                      ? null
                      : controller.panError.value,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: _primaryRed,
                      width: 1.2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.red, width: 1.2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.red, width: 1.2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.info_outline_rounded, size: 13, color: Colors.grey),
                SizedBox(width: 5),
                Text(
                  'OTP will be sent to your registered mobile',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 32),

            CustomButton(
              text: 'Continue',
              btncolor: const Color(0xFF111111),
              onPressed: () {
                if (controller.pan.value.isEmpty) {
                  controller.panError.value = 'PAN number is required';
                  return;
                }
                if (!controller.isButtonEnabled.value) {
                  controller.panError.value =
                      'Invalid PAN format (e.g. ABCDE1234F)';
                  return;
                }
                controller.showOtpBottomSheet(context);
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StepPill extends StatelessWidget {
  final String label;
  final bool active;
  final bool done;
  const _StepPill({
    required this.label,
    this.active = false,
    this.done = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: (active || done)
            ? Colors.white.withOpacity(0.22)
            : Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(active ? 0.6 : 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (done)
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 12,
            ),
          if (done) const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(active || done ? 1.0 : 0.5),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE53935).withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFE53935), size: 22),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111111),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
