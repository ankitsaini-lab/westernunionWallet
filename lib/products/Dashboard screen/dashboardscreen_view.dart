import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Dashboard%20screen/dashboardscreen_Controller.dart';
import 'package:transwallet/products/Notification%20screen/notification_View.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/globalbottombar/Globalbottombar_View.dart';
class DashboardscreenView extends GetView<DashboardscreenController> {
  const DashboardscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DashboardscreenController());

   
    const primaryRed = Color(0xFFD64550);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      bottomNavigationBar: GlobalbottombarView(seletedIndex: 0.obs),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primaryRed.withOpacity(0.2), width: 2),
                image: const DecorationImage(
                  image: AssetImage("assets/360_F_244436923_vkMe10KKKiw5bjhZeRDT05moxWcPpdmb.jpg"),  
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome", style: TextStyle(color: Colors.black54, fontSize: 12)),
                Text("Jane Doe", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.black87, size: 28),
            onPressed: () {
              // Get.toNamed("/notification");
               Get.bottomSheet(
      NotificationView(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ); 
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               
              Container(
                height: 270,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: controller.walletCard(showhide: true),
              ),

              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () => Get.toNamed("/updateKyc"),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: primaryRed.withOpacity(0.05),  
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: primaryRed.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.verified_user_rounded, color: primaryRed),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Text(
                            "Complete Full KYC to unlock all features",
                            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: primaryRed)
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

               
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Transactions",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed("/history");
                      },
                      child: const Text("See All", style: TextStyle(color: primaryRed, fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    controller.tile("B", "Blinkit", "- ₹240"),
                    controller.tile("Z", "Zomato", "- ₹635"),
                    controller.tile("J", "Jane Doe", "+ ₹2500"),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
