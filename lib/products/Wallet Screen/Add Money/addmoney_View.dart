import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'addmoney_Controller.dart';

class AddmoneyView extends StatelessWidget {
  const AddmoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddmoneyController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! > 10) {
            Get.back();
          }
        },
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(top: 120),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            controller.circleBtn(Icons.remove, () {
                              if (controller.sliderValue.value > 5) {
                                controller.sliderValue.value -= 5;
                                controller.enteredAmount.value =
                                    controller.sliderValue.value
                                        .toInt()
                                        .toString();
                              }
                            }),
                            const SizedBox(width: 15),

                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "₹${controller.formatAmount(
                                    controller.isCustom.value
                                        ? controller.enteredAmount.value
                                        : controller.sliderValue.value
                                            .toInt()
                                            .toString(),
                                  )}",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: controller.getFontSize(
                                        controller.enteredAmount.value),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 20),

                            controller.circleBtn(Icons.add, () {
                              controller.sliderValue.value += 5;
                              controller.enteredAmount.value =
                                  controller.sliderValue.value
                                      .toInt()
                                      .toString();
                            }),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Slider(
                          min: 5,
                          max: 1000,
                          value: controller.sliderValue.value,
                          onChanged: (val) {
                            controller.isCustom.value = false;
                            controller.sliderValue.value = val;
                            controller.enteredAmount.value =
                                val.toInt().toString();
                            FocusScope.of(context).unfocus();
                          },
                          activeColor: Colors.red,
                        ),

                        GridView.count(
                          crossAxisCount: 4,
                          shrinkWrap: true,
                          childAspectRatio: 1.5,
                          children: [   100, 200, 500, -1]
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      if (e == -1) {
                                        controller.isCustom.value = true;
                                        controller.enteredAmount.value = "";
                                        controller.customController.clear();

                                        Future.delayed(
                                            const Duration(milliseconds: 100),
                                            () {
                                          FocusScope.of(context).requestFocus(
                                              controller.customFocus);
                                        });
                                      } else {
                                        controller.isCustom.value = false;
                                        controller.sliderValue.value =
                                            e.toDouble();
                                        controller.enteredAmount.value =
                                            e.toString();
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: (e == -1 &&
                                                    controller.isCustom.value) ||
                                                (e != -1 &&
                                                    !controller.isCustom.value &&
                                                    controller.sliderValue.value ==
                                                        e)
                                            ? Colors.red
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          e == -1 ? "Custom" : "₹$e",
                                          style: TextStyle(
                                            color: (e == -1 &&
                                                        controller.isCustom.value) ||
                                                    (e != -1 &&
                                                        !controller.isCustom.value &&
                                                        controller.sliderValue.value ==
                                                            e)
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),

                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: controller.isCustom.value ? 45 : 0,
                          margin: const EdgeInsets.only(top: 5),
                          child: controller.isCustom.value
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextField(
                                    controller: controller.customController,
                                    focusNode: controller.customFocus,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(9),
                                    ],
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 8,bottom: 3),
                                      border: InputBorder.none,
                                      hintText: "Enter amount",
                                    ),
                                    onChanged: (val) {
                                      controller.enteredAmount.value = val;
                                    },
                                  ),
                                )
                              : const SizedBox(),
                        ),

                        const SizedBox(height: 20),

                        GestureDetector(
                          onTap: controller.isProcessing.value
                              ? null
                              : controller.payNow,
                          child: Obx(() => Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: controller.isProcessing.value
                                      ? const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 18,
                                              width: 18,
                                              child:
                                                  CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Processing...",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )
                                      : const Text(
                                          "Pay Now",
                                          style:
                                              TextStyle(color: Colors.white),
                                        ),
                                ),
                              )),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  )),
            ),

            Obx(() => controller.showSuccess.value
                ? Center(
                    child: AnimatedScale(
                      scale: controller.showSuccess.value ? 1 : 0,
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 40),
                      ),
                    ),
                  )
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}