import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfilescreenController extends GetxController {
  var selectedIndex = 3.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void onMenuTap(String title) {
    
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
  const Color primaryRed = Color(0xFFE53935);
  const Color textColor = Color(0xFF111111);
  const Color secondaryText = Color(0xFF4B5563);
  const Color borderColor = Color(0xFFECECEC);

  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            Container(
              height: 74,
              width: 74,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFE53935), Color(0xFFC62828)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryRed.withOpacity(0.25),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(height: 24),

            
            const Text(
              "Secure Sign Out",
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 10),

            
            const Text(
              "Are you sure you want to sign out of your Transcorp account? You will need your credentials to sign back in.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: secondaryText,
                fontSize: 13,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32),

            
            Row(
              children: [
                
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Get.back(),
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Get.back();
                      performLogout();
                    },
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: textColor, 
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        "Sign Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
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
    barrierColor: Colors.black.withOpacity(0.4),
    barrierDismissible: false,
  );
}
void performLogout() {
 

  Get.offAllNamed('/');  
}
}