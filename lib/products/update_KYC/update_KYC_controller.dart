import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/custombutton.dart';
import 'package:confetti/confetti.dart';

class UpdateKycController extends GetxController {
 var isConsentChecked = false.obs;
  var isFullKycStarted = false.obs;

  void toggleConsent(bool value) {
    isConsentChecked.value = value;
  }

  void proceedToFullKyc() {
    if (isConsentChecked.value) {
      isFullKycStarted.value = true;
    }
  }
Widget updateKycView() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// 🔥 TOP TEXT
        const Text(
          "Effortlessly verify your identity to enjoy uninterrupted access to everything we offer.",
          style: TextStyle(color: Colors.grey, height: 1.5),
        ),

        const SizedBox(height: 24),

        const Text(
          "Choose your KYC",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 20),

        /// 🧊 MIN KYC CARD
        _kycCard(
          icon: Icons.check_circle,
          title: "Min KYC",
          isActive: true,
          description1: "The maximum wallet limit is ₹10,000",
          description2: "Quickly verify with basic details for limited access.",
        ),

        const SizedBox(height: 14),

        /// 🧊 FULL KYC CARD
        _kycCard(
          icon: Icons.radio_button_checked,
          title: "Full KYC",
          isActive: false,
          description1: "The maximum wallet limit is ₹10,000",
          description2: "Quickly verify with basic details for limited access.",
        ),

        const Spacer(),

        /// 🔘 CONSENT
        Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: isConsentChecked.value,
                  onChanged: (val) => toggleConsent(val!),
                ),
                const Expanded(
                  child: Text(
                    "I hereby consent to share my Aadhaar number, biometric data, or OTP for Aadhaar-based authentication, solely for KYC purposes, in compliance with applicable regulations",
                    style: TextStyle(height: 1.4),
                  ),
                )
              ],
            )),

        const SizedBox(height: 20),

        /// 🔘 BUTTON
        Obx(() => CustomButton(
              text: "Proceed to Full KYC",
              btncolor:
                  isConsentChecked.value ? Colors.black : Colors.grey,
              onPressed: () {
                if (isConsentChecked.value) {
                  proceedToFullKyc();
                }
              },
            )),

        const SizedBox(height: 20),
      ],
    ),
  );
}
   Widget _kycCard({
  required IconData icon,
  required String title,
  required bool isActive,
  required String description1,
  required String description2,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isActive ? Colors.green : Colors.transparent,
        width: 1.2,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Icon(icon, color: isActive ? Colors.green : Colors.grey),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14),
              ),

              const SizedBox(height: 6),

              Text(
                description1,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),

              const SizedBox(height: 4),

              Text(
                description2,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

 Widget fullKycView() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Get ready to complete your Full KYC—keep your PAN & Aadhaar card handy for a smooth process.",
          style: TextStyle(color: Colors.grey, height: 1.5),
        ),

        const SizedBox(height: 24),

        const Text(
          "Full KYC Steps",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 20),

        /// 🧊 STEP CARDS
        _stepCard("Upload PAN", Icons.upload,
            "Keep your PAN card handy as you’ll be asked to upload a photo of it."),

        _stepCard("Validate Aadhaar", Icons.verified,
            "OTP will be sent to your registered mobile number for Aadhaar-based authentication."),

        _stepCard("Video Call", Icons.video_call,
            "A video call will be set with the KYC agent to complete the KYC process."),

        const Spacer(),

        CustomButton(
          text: "Get Started",
          btncolor: Colors.black,
          onPressed: () => showKycSuccessPopup(),
        ),

        const SizedBox(height: 20),
      ],
    ),
  );
}
  Widget _stepCard(String title, IconData icon, String desc) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(
                    color: Colors.grey, fontSize: 12, height: 1.4),
              )
            ],
          ),
        )
      ],
    ),
  );
}
///////////
 late ConfettiController confettiController = ConfettiController(duration: const Duration(seconds: 10,));

 
 

  void playAnimation() {
    confettiController.play();

  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }
  void showKycSuccessPopup() {
  

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
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
                const Icon(
                  Icons.verified,
                  color: Colors.green,
                  size: 60,
                ),
                const SizedBox(height: 10),

                const Text(
                  "Congratulations 🎉",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Your Full KYC is Successfully Completed.\nYou can now enjoy all features!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 20),
CustomButton(text: "Go to Dashboard", btncolor: Colors.black, onPressed: () {
                  Get.back();
                  Get.offAllNamed("/dashboard");
                })

                 
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