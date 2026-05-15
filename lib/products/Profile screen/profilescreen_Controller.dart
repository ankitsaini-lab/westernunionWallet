import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfilescreenController extends GetxController {
   var selectedIndex = 3.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void onMenuTap(String title) {
    // Get.toNamed('/dummy', arguments: title);
  }
Widget menuItem(
  String title,
  String icon, {
  VoidCallback? onTap,
  bool isLogout = false,
}) {
  return ListTile(
    
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
      ),
      child: 
      SvgPicture.asset(icon.toString(),height: 18,),
       
    ),
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: isLogout ? Colors.redAccent : Colors.black,
      ),
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios,
      size: 12,
      color: Colors.black38,
    ),
    onTap: onTap,
  );
}
void showLuxuryLogoutDialog(BuildContext context) {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.25),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Icon
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.redAccent.withOpacity(0.8),
                        Colors.deepOrange.withOpacity(0.6),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.power_settings_new_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 20),

                /// Title
                const Text(
                  "Sign Out",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                /// Subtitle
                const Text(
                "Are you sure you want to sign out?\nYou can sign back in anytime.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),

                const SizedBox(height: 28),

                /// Buttons
                Row(
                  children: [
                    /// Stay
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => Get.back(),
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                          child: const Text("Stay"),
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    /// Logout
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Get.back();
                          performLogout();
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF0E0E11),
                                Color(0xFF2A2A2E),
                              ],
                            ),
                          ),
                          child: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.white),
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
    ),

    barrierColor: Colors.black.withOpacity(0.35),
    barrierDismissible: false,
  );
}
void performLogout() {
 

  Get.offAllNamed('/');  
}
}