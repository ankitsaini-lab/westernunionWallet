import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/utilities/getStorage.dart';
import 'package:transwallet/widgets/premium_visa_card.dart';

class FeatureControl {
  RxBool enabled;
  RxDouble limit;

  FeatureControl({bool enabled = false, double limit = 50})
    : enabled = enabled.obs,
      limit = limit.obs;
}

class ManagecardController extends GetxController {
  final RxBool isCardBlocked = false.obs;
  final atm = FeatureControl(enabled: true, limit: 100);
  final pos = FeatureControl();
  final ecom = FeatureControl();
  final international = FeatureControl();
  final dcc = FeatureControl();
  final contactless = FeatureControl();
  void toggleCardStatus() {
    isCardBlocked.toggle();
  }

  void showBlockUnblockDialog() {
    Get.dialog(
      Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,

        child: Obx(
          () => Container(
            padding: const EdgeInsets.all(22),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 55,
                  width: 55,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: isCardBlocked.value
                        ? Colors.green.withOpacity(.1)
                        : const Color(0xFF111111).withOpacity(.1),
                  ),

                  child: Icon(
                    isCardBlocked.value
                        ? Icons.lock_open_rounded
                        : Icons.lock_outline_rounded,

                    size: 24,

                    color: isCardBlocked.value
                        ? Colors.green
                        : const Color(0xFF111111),
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  isCardBlocked.value ? "Unblock Card" : "Block Card",

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                height12,

                Text(
                  isCardBlocked.value
                      ? "Your card will be activated again."
                      : "Your card will be temporarily disabled.",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),

                height24,

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: Get.back,

                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),

                        child: const Text("Cancel"),
                      ),
                    ),

                    width12,

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          toggleCardStatus();
                          Get.back();

                          Get.snackbar(
                            "Success",
                            isCardBlocked.value
                                ? "Card Blocked"
                                : "Card Unblocked",

                            snackPosition: SnackPosition.BOTTOM,

                            backgroundColor: Colors.black,
                            colorText: Colors.white,

                            margin: const EdgeInsets.all(14),
                            borderRadius: 12,
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: isCardBlocked.value
                              ? Colors.green
                              : const Color(0xFF111111),

                          elevation: 0,

                          padding: const EdgeInsets.symmetric(vertical: 15),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),

                        child: Text(
                          isCardBlocked.value ? "Unblock" : "Block",

                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      barrierDismissible: false,
    );
  }

  Widget cardPreview() {
    final box = GetStorage();
    return Obx(
      () => Center(
        child: PremiumVisaCard(
          cardNumber: "••••••••••••4567",
          cardHolder: box.read('name') ?? "John Doe",
          expiryDate: "12/28",
          cvv: "•••",
          isBlocked: isCardBlocked.value,
        ),
      ),
    );
  }
}

Widget featureTile(String title, FeatureControl control) {
  return Obx(
    () => Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                title,

                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              PremiumToggle(
                value: control.enabled.value,

                onChanged: (value) {
                  control.enabled.value = value;
                },
              ),
            ],
          ),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),

            child: control.enabled.value
                ? Column(
                    children: [
                      const SizedBox(height: 18),

                      PremiumSlider(
                        value: control.limit.value,

                        min: 5000,
                        max: 500000,

                        onChanged: (value) {
                          control.limit.value = value;
                        },
                      ),

                      const SizedBox(height: 12),

                      Align(
                        alignment: Alignment.centerRight,

                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(0xFFFFCC00).withOpacity(.15),

                            borderRadius: BorderRadius.circular(30),
                          ),

                          child: Text(
                            "Limit: ${control.limit.value.toInt()}",

                            style: const TextStyle(
                              color: const Color(0xFF111111),

                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    ),
  );
}

class PremiumToggle extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const PremiumToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        width: 55,
        height: 31,

        padding: const EdgeInsets.all(3),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),

          gradient: value
              ? const LinearGradient(
                  colors: [Color(0xFFFFB300), Color(0xFFFFCC00)],
                )
              : null,

          color: value ? null : Colors.grey.shade300,
        ),

        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),

          alignment: value ? Alignment.centerRight : Alignment.centerLeft,

          child: Container(
            width: 25,
            height: 25,

            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class PremiumSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final Function(double) onChanged;

  const PremiumSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 500,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 5,

            activeTrackColor: const Color(0xFFFFCC00),
            inactiveTrackColor: const Color(0xFFFFCC00).withOpacity(0.18),
            thumbColor: Colors.white,
            overlayColor: const Color(0xFFFFCC00).withOpacity(.15),

            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 11),
          ),

          child: Slider(
            value: value.clamp(min, max),

            min: min,
            max: max,

            onChanged: onChanged,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                "Min: ${min.toInt()}",

                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Text(
                "Max: ${max.toInt()}",

                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
