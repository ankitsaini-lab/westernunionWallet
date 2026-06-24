import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Order%20Card%20screen/Review%20order%20Details/review_order_details_Controller.dart';
import 'package:transwallet/widgets/custombutton.dart';

class ReviewOrderDetailsView extends GetView<ReviewOrderDetailsController> {
  const ReviewOrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ReviewOrderDetailsController());

    const Color secondaryText = Color(0xFF6B7280);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth > 768;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 22,
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Delivery Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 20,
            letterSpacing: -0.5,
            ////value testing git
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
              child: isWideScreen
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  const SizedBox(height: 12),
                                  _buildLiveCardPreview(),
                                  const SizedBox(height: 20),
                                  _buildExtraCardDetails(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 32),

                          Expanded(
                            flex: 3,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "SHIPPING INFORMATION",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: secondaryText,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  _buildShippingForm(),
                                  const SizedBox(height: 24),
                                  _buildProceedButton(),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(child: _buildLiveCardPreview()),
                                const SizedBox(height: 28),
                                const Text(
                                  "SHIPPING INFORMATION",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryText,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                _buildShippingForm(),
                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: _buildProceedButton(),
                        ),
                      ],
                    ),
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
        color: const Color(0xFFE5E7EB).withValues(alpha: 0.4),
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
              Icon(Icons.circle, color: Colors.black, size: 10),
              SizedBox(width: 6),
              Text(
                "Shipping",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 16),
          Row(
            children: [
              Icon(Icons.circle_outlined, color: Colors.grey, size: 10),
              SizedBox(width: 6),
              Text(
                "Payment",
                style: TextStyle(
                  color: Colors.grey,
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

  Widget _buildLiveCardPreview() {
    return Obx(() {
      final glowColor = controller.cardGlowColor.value;
      final namePrinted = controller.name.value;

      return AspectRatio(
        aspectRatio: 85.60 / 45,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/unioncardblack.webp'),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: glowColor.withValues(alpha: 0.35),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 26,
                          width: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFECB3), Color(0xFFE5C158)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.contactless_rounded,
                          color: Colors.white70,
                          size: 18,
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "••••  ••••  ••••  8824",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                namePrinted.isEmpty
                                    ? "YOUR NAME HERE"
                                    : namePrinted.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: namePrinted.isEmpty
                                      ? Colors.white70.withValues(alpha: 0.6)
                                      : Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
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
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildShippingForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFECECEC), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.015),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Obx(
            () => _buildInputField(
              label: "Name on Card",
              controller: controller.nameController,
              errorText: controller.nameError,
              keyboardType: TextInputType.name,
              prefixIcon: Icons.badge_rounded,
            ),
          ),
          const SizedBox(height: 16),

          Obx(
            () => _buildInputField(
              label: "Address Line 1",
              controller: controller.address1Controller,
              errorText: controller.address1Error,
              keyboardType: TextInputType.streetAddress,
              prefixIcon: Icons.home_rounded,
            ),
          ),
          const SizedBox(height: 16),

          _buildInputField(
            label: "Address Line 2 (Optional)",
            controller: controller.address2Controller,
            keyboardType: TextInputType.streetAddress,
            prefixIcon: Icons.location_city_rounded,
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(
                  () => _buildInputField(
                    label: "Pincode",
                    controller: controller.pincodeController,
                    errorText: controller.pincodeError,
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.pin_drop_rounded,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Obx(
                  () => _buildInputField(
                    label: "City",
                    controller: controller.cityController,
                    errorText: controller.cityError,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.map_rounded,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(
                  () => _buildInputField(
                    label: "State",
                    controller: controller.stateController,
                    errorText: controller.stateError,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.explore_rounded,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildInputField(
                  label: "Country",
                  controller: controller.countryController,
                  enabled: false,
                  prefixIcon: Icons.flag_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProceedButton() {
    return Obx(() {
      final isEnabled = controller.isFormValid;
      return CustomButton(
        text: "Proceed to pay ₹${controller.amount.value}",
        btncolor: isEnabled ? Colors.black : Colors.grey.shade400,
        suffixIcon: isEnabled
            ? const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 18,
              )
            : null,
        onPressed: () {
          if (isEnabled) {
            Get.toNamed('/paymentmethod');
          }
        },
      );
    });
  }

  Widget _buildExtraCardDetails() {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFECECEC), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.005),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.security_rounded, color: Colors.black, size: 18),
              SizedBox(width: 8),
              Text(
                "Secure Verification",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111111),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Please ensure the name on the card matches your official government ID. Shipping takes 5-7 business days.",
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? errorText,
    TextInputType keyboardType = TextInputType.text,
    IconData? prefixIcon,
    bool enabled = true,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF111111),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xFF6B7280),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        errorText: errorText,
        errorStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: enabled ? const Color(0xFFF9FAFB) : const Color(0xFFF3F4F6),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: enabled
                    ? const Color(0xFF6B7280)
                    : const Color(0xFF9CA3AF),
                size: 16,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
