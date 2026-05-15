import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transwallet/widgets/custombutton.dart';

class MinkycscreenController extends GetxController {
  var pan = ''.obs;
  var isButtonEnabled = false.obs;
  var otp = ''.obs;

  void onPanChanged(String value) {
    pan.value = value;
    isButtonEnabled.value = value.length >= 10;  
  }
void showOtpBottomSheet(BuildContext context) {
  List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  List<FocusNode> focusNodes =
      List.generate(4, (_) => FocusNode());

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// 🔥 HANDLE
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const Text(
            "Enter OTP",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Verify your PAN details",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 25),

          /// 🔢 OTP BOXES (Premium)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              return SizedBox(
                width: 60,
                child: TextField(
                  controller: controllers[index],
                  focusNode: focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  inputFormatters: [ FilteringTextInputFormatter.digitsOnly,],
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFFE53935),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (index < 3) {
                        FocusScope.of(Get.context!)
                            .requestFocus(focusNodes[index + 1]);
                      }
                    } else if (index > 0) {
                      FocusScope.of(Get.context!)
                          .requestFocus(focusNodes[index - 1]);
                    }

                    otp.value = controllers.map((c) => c.text).join();
                  },
                ),
              );
            }),
          ),

          const SizedBox(height: 25),

        
          Obx(() => CustomButton(
                text: "Verify",
                btncolor: const Color(0xFF111111),
                onPressed: otp.value.length == 4
                    ? (){
                      Get.back(); 
                      showSuccessDialog();
                    }
                    : () {},
              )),

          const SizedBox(height: 10),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}
void showSuccessDialog() {
  Get.dialog(
    Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 280,
         
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

           
            Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                color: Color(0xFF22C55E),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 35,
              ),
            ),

            const SizedBox(height: 18),

             
            const Text(
              "Min KYC Completed",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111111),
              ),
            ),

            const SizedBox(height: 10),

             
            const Text(
              "Your account is now active with basic access.\n"
              "Complete Full KYC to unlock all features and benefits.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ),
  barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.3),
  );

   
  Future.delayed(const Duration(seconds: 2), () {
    if (Get.isDialogOpen ?? false) {
      Get.back();
   
    }
       Get.offAllNamed('/dashboard');  
  });
}}