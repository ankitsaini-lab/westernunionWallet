import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/utilities/getStorage.dart';

class ProfileDetailsController extends GetxController {
  var profileImage =
      "assets/360_F_244436923_vkMe10KKKiw5bjhZeRDT05moxWcPpdmb.jpg".obs;

  RxString name = "".obs;
  RxString email = "".obs;
  RxString phone = "".obs;
  RxString accountverification = "Verified Account".obs;
  RxString address = "".obs;

  @override
  void onInit() {
    super.onInit();
    name.value = box.read('name') ?? "Jane Doe";
    email.value = box.read('email') ?? "vince.tallent@westernunion.com";
    phone.value = "+91 ${box.read('phone') ?? '9876543210'}";
    address.value = box.read('address') ?? "Singapore,India";
  }

  Widget buildTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFFCC00).withOpacity(.15),
                  const Color(0xFFFFCC00).withOpacity(.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFF111111), size: 26),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
