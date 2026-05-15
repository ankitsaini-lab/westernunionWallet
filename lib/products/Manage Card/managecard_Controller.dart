import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/widgets/constsize.dart';
class FeatureControl {
  RxBool enabled;
  RxDouble limit;

  FeatureControl({
    bool enabled = false,
    double limit = 50,
  })  : enabled = enabled.obs,
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
                        : const Color(0xFFD90429)
                            .withOpacity(.1),
                  ),

                  child: Icon(
                    isCardBlocked.value
                        ? Icons.lock_open_rounded
                        : Icons.lock_outline_rounded,

                    size: 24,

                    color: isCardBlocked.value
                        ? Colors.green
                        : const Color(0xFFD90429),
                  ),
                ),

                const SizedBox(height: 18),

                /// TITLE
                Text(
                  isCardBlocked.value
                      ? "Unblock Card"
                      : "Block Card",

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
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),

                        child: const Text(
                          "Cancel",
                        ),
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

                            snackPosition:
                                SnackPosition.BOTTOM,

                            backgroundColor: Colors.black,
                            colorText: Colors.white,

                            margin: const EdgeInsets.all(14),
                            borderRadius: 12,
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isCardBlocked.value
                                  ? Colors.green
                                  : const Color(
                                      0xFFD90429,
                                    ),

                          elevation: 0,

                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 15,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),

                        child: Text(
                          isCardBlocked.value
                              ? "Unblock"
                              : "Block",

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
  return Obx(
    () => Container(
      height: 210,
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: isCardBlocked.value
              ? [
                  const Color(0xFF4A4A4A),
                  const Color(0xFF2C2C2C),
                  const Color(0xFF121212),
                ]
              : [
                  const Color(0xFFFF2E4D),
                  const Color(0xFFD90429),
                  const Color(0xFF8D021F),
                ],
        ),

        boxShadow: [
          BoxShadow(
            color:  isCardBlocked.value
                ? Colors.black.withOpacity(.18)
                : Colors.red.withOpacity(.25),

            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),

      child: Stack(
        children: [
          /// TOP CIRCLE
          Positioned(
            top: -20,
            left: -10,
            child: Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.06),
              ),
            ),
          ),

          /// BOTTOM CIRCLE
          Positioned(
            bottom: -40,
            right: -20,
            child: Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.05),
              ),
            ),
          ),

          /// BLOCKED LABEL
          if (isCardBlocked.value)
            Positioned(
              top: 18,
              left: 18,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.18),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.redAccent,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.block,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "CARD BLOCKED",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          /// CARD CONTENT
          Padding(
            padding: const EdgeInsets.all(22),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Align(
                  alignment: Alignment.topRight,

                  child: Text(
                     isCardBlocked.value
                        ? "BLOCKED"
                        : "TRANSCORP",

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                const Spacer(),

                /// CARD NUMBER
                Opacity(
                  opacity:
                       isCardBlocked.value
                          ? 0.55
                          : 1,
                  child: const Text(
                    "****  ****  ****  4567",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [
                    /// HOLDER
                    Opacity(
                      opacity:
                          isCardBlocked.value
                              ? 0.55
                              : 1,
                      child: const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Text(
                            "CARD HOLDER",

                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            "John Doe",

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// VALID
                    Opacity(
                      opacity:
                          isCardBlocked.value
                              ? 0.55
                              : 1,
                      child: const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Text(
                            "VALID THRU",

                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            "06/28",

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ],
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
  );
}
}
Widget featureTile(
  String title,
  FeatureControl control,
) {
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
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

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
                        value:
                            control.limit.value,

                        min: 5000,
                        max: 500000,

                        onChanged: (value) {
                          control.limit.value =
                              value;
                        },
                      ),

                      const SizedBox(height: 12),

                      Align(
                        alignment:
                            Alignment.centerRight,

                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFD90429,
                            ).withOpacity(.08),

                            borderRadius:
                                BorderRadius.circular(
                              30,
                            ),
                          ),

                          child: Text(
                            "Limit: ${control.limit.value.toInt()}",

                            style: const TextStyle(
                              color:
                                  Color(0xFFD90429),

                              fontWeight:
                                  FontWeight.w500,
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
          borderRadius:
              BorderRadius.circular(30),

          gradient: value
              ? const LinearGradient(
                  colors: [
                    Color(0xFFFF2E4D),
                    Color(0xFFD90429),
                  ],
                )
              : null,

          color:
              value ? null : Colors.grey.shade300,
        ),

        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),

          alignment: value
              ? Alignment.centerRight
              : Alignment.centerLeft,

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

            activeTrackColor:
                const Color(0xFFD90429),

            inactiveTrackColor:
                Colors.red.shade100,

            thumbColor: Colors.white,

            overlayColor:
                Colors.red.withOpacity(.15),

            thumbShape:
                const RoundSliderThumbShape(
              enabledThumbRadius: 11,
            ),
          ),

          child: Slider(
            value: value.clamp(min, max),

            min: min,
            max: max,

            onChanged: onChanged,
          ),
        ),

        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 4),

          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

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