import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/widgets/globalbottombar/GlobalbottomBar_Controller.dart';

class GlobalbottombarView extends GetView<GlobalbottombarController>   {
  var seletedIndex ;
    GlobalbottombarView({super.key,required this.seletedIndex});

   
@override
Widget build(BuildContext context) {
  Get.lazyPut(() => GlobalbottombarController());

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    height: 70,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(40),
    ),
    child: Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(controller.icons.length, (index) {
          bool isSelected = seletedIndex.value == index;

          return GestureDetector(
            onTap: () => controller.changeIndex(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black87 : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  controller.icons[index],
                  color: isSelected ? Colors.white : Colors.grey,
                  size: 26,
                ),
              ),
            ),
          );
        }),
      ),
    ),
  );

}}