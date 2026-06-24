import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Send%20money%20screen/sendMoney_Controller.dart';
import 'package:transwallet/widgets/custombutton.dart';

class SendmoneyView extends GetView<SendmoneyController> {
  const SendmoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SendmoneyController());
    const Color primaryRed = Color(0xFFFFCC00);
    const Color textColor = Color(0xFF111111);
    const Color secondaryText = Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), 
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black, size: 22),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Send Money",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 20,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Obx(() {
                final isP2P = controller.istransferTypeP2P.value;
                return Container(
                  height: 52,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.istransferTypeP2P.value = true;
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOutCubic,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isP2P ? Colors.black : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: isP2P
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      )
                                    ]
                                  : [],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone_android_rounded,
                                  color: isP2P ? Colors.white : secondaryText,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "To Mobile",
                                  style: TextStyle(
                                    color: isP2P ? Colors.white : secondaryText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.istransferTypeP2P.value = false;
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOutCubic,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: !isP2P ? Colors.black : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: !isP2P
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      )
                                    ]
                                  : [],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.account_balance_rounded,
                                  color: !isP2P ? Colors.white : secondaryText,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "Bank Account",
                                  style: TextStyle(
                                    color: !isP2P ? Colors.white : secondaryText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    letterSpacing: -0.2,
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
              }),

              const SizedBox(height: 24),

              
              Obx(() {
                final isP2P = controller.istransferTypeP2P.value;
                if (isP2P) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: const Color(0xFFECECEC), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "RECIPIENT MOBILE",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: secondaryText,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 14),
                            TextField(
                              keyboardType: TextInputType.phone,
                              controller: controller.phoneController,
                              onChanged: (v) {
                                controller.selectedContactName.value = '';
                                controller.updateNumber(v);
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                letterSpacing: 1.0,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFFF9FAFB),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                                  child: Text(
                                    controller.selectedCountryCode.value,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                                prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                                hintText: "00000 00000",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                                errorText: controller.phoneError.value.isEmpty ? null : controller.phoneError.value,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.contact_page_rounded, color: Color(0xFF111111), size: 22),
                                  onPressed: () => Get.to(() => ContactPage()),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                                ),
                              ),
                            ),
                            
                            
                            Obx(() {
                              final contactName = controller.selectedContactName.value;
                              if (contactName.isEmpty) return const SizedBox();
                              return Column(
                                children: [
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4CAF50).withOpacity(0.06),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.15), width: 1),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 38,
                                          width: 38,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF4CAF50),
                                            shape: BoxShape.circle,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            contactName[0].toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                contactName,
                                                style: const TextStyle(
                                                  color: textColor,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              const Row(
                                                children: [
                                                  Icon(Icons.verified_user_rounded, color: Color(0xFF4CAF50), size: 10),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "Western Union User Verified",
                                                    style: TextStyle(
                                                      color: Color(0xFF4CAF50),
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),
                      
                      Obx(() {
                        final isEnabled = controller.isValid.value;
                        return CustomButton(
                          text: "Proceed to Pay",
                          btncolor: isEnabled ? Colors.black : Colors.grey.shade400,
                          onPressed: () {
                            if (isEnabled) {
                              Get.toNamed("/sendmoneyprocess");
                            }
                          },
                        );
                      }),
                    ],
                  );
                } else {
                  
                  return controller.buildStep();
                }
              }),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}