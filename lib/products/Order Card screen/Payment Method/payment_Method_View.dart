import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Order%20Card%20screen/Payment%20Method/payment_Method_Controller.dart';
import 'package:transwallet/widgets/custombutton.dart';

class PaymentMethodView extends GetView<PaymentMethodController> {
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PaymentMethodController());

    const Color primaryRed = Color(0xFFE53935);
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
          "Payment Method",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 20,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: _buildStepperProgress(),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    const Text(
                      "ORDER SUMMARY",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: secondaryText,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInvoiceSummaryCard(),

                    const SizedBox(height: 28),

                    
                    const Text(
                      "PAYMENT OPTIONS",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: secondaryText,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 12),

                    
                    Obx(() {
                      final isSelected = controller.selectedMethod.value == 1;
                      final isLowBalance = controller.walletBalance.value < controller.amount.value;

                      return GestureDetector(
                        onTap: () => controller.selectedMethod.value = 1,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? Colors.black : const Color(0xFFECECEC),
                              width: isSelected ? 2.0 : 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(isSelected ? 0.03 : 0.005),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Radio<int>(
                                activeColor: Colors.black,
                                value: 1,
                                groupValue: controller.selectedMethod.value,
                                onChanged: (val) {
                                  if (val != null) controller.selectedMethod.value = val;
                                },
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "General Wallet",
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Balance: ₹${controller.walletBalance.value}.00",
                                      style: TextStyle(
                                        color: isLowBalance ? primaryRed : const Color(0xFF4CAF50),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.walletBalance.value += 500;
                                  Get.snackbar(
                                    "Wallet Top-Up",
                                    "₹500.00 added to your General Wallet.",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: const Color(0xFF4CAF50),
                                    colorText: Colors.white,
                                    borderRadius: 16,
                                    margin: const EdgeInsets.all(16),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE53935).withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    "Add ₹500",
                                    style: TextStyle(
                                      color: primaryRed,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 12),

                    
                    Obx(() {
                      final isSelected = controller.selectedMethod.value == 2;
                      return GestureDetector(
                        onTap: () => controller.selectedMethod.value = 2,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? Colors.black : const Color(0xFFECECEC),
                              width: isSelected ? 2.0 : 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Radio<int>(
                                activeColor: Colors.black,
                                value: 2,
                                groupValue: controller.selectedMethod.value,
                                onChanged: (val) {
                                  if (val != null) controller.selectedMethod.value = val;
                                },
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "Other Payment Options (UPI / NetBanking)",
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    
                    
                    Obx(() {
                      final isLowBalance = controller.selectedMethod.value == 1 &&
                          controller.walletBalance.value < controller.amount.value;
                      if (!isLowBalance) return const SizedBox();
                      return Column(
                        children: [
                          const SizedBox(height: 18),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: primaryRed.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: primaryRed.withOpacity(0.15), width: 1),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.warning_amber_rounded, color: primaryRed, size: 18),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "Insufficient balance. Top-up your wallet using the 'Add ₹500' button to proceed.",
                                    style: TextStyle(
                                      color: primaryRed,
                                      fontSize: 11.5,
                                      height: 1.3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Obx(() {
                final isLowBalance = controller.selectedMethod.value == 1 &&
                    controller.walletBalance.value < controller.amount.value;
                final isEnabled = !isLowBalance;

                return CustomButton(
                  text: "Pay ₹${controller.amount.value}.00 Now",
                  btncolor: isEnabled ? Colors.black : Colors.grey.shade400,
                  onPressed: () {
                    if (isEnabled) {
                      controller.processPayment();
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperProgress() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB).withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.green, size: 16),
              SizedBox(width: 6),
              Text(
                "Design",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 16),
          Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.green, size: 16),
              SizedBox(width: 6),
              Text(
                "Shipping",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 16),
          Row(
            children: [
              Icon(Icons.circle, color: Colors.black, size: 10),
              SizedBox(width: 6),
              Text(
                "Payment",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFECECEC), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            children: [
              Obx(() => Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: controller.cardGradient),
                    ),
                  )),
              const SizedBox(width: 10),
              Obx(() => Text(
                    controller.cardStyleName.value,
                    style: const TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const Spacer(),
              const Text(
                "₹150.00",
                style: TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          const SizedBox(height: 12),

          
          const Text(
            "CARDHOLDER NAME",
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9CA3AF),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Obx(() => Text(
                controller.receiverName.value.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )),
          
          const SizedBox(height: 12),

          
          const Text(
            "SHIPPING ADDRESS",
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9CA3AF),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Obx(() => Text(
                controller.deliveryAddress.value,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              )),
        ],
      ),
    );
  }
}