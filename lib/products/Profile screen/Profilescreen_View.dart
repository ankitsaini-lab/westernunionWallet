import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Profile%20screen/profilescreen_Controller.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/custombutton.dart';

class ProfilescreenView extends GetView<ProfilescreenController> {
  const ProfilescreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfilescreenController());

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.80,
            minChildSize: 0.7,
            maxChildSize: 0.95,
            builder: (_, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                            ),
                            child: Image.asset(
                              "assets/image.png",
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                height: 5,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -45,
                            left: 20,
                            right: 20,
                            child: Row(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // border: Border(
                                    //   top: BorderSide( color: Colors.red, width: 1.5),
                                    //    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.redAccent.withOpacity(0.2),
                                        blurRadius: 15,
                                      )
                                    ],
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/360_F_244436923_vkMe10KKKiw5bjhZeRDT05moxWcPpdmb.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                             
                              ],
                            ),
                          ),
                      Positioned(
                     bottom: -43,
                     left: Get.width * 0.2,
                        child: GestureDetector(
                          
                          onTap: () {
                            
                          },
                          child: Icon(Icons.camera_alt_outlined,color: Colors.black,)))
                      
                        ],
                      ),
                     
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20),
                           child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Jane Doe",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Jane.doe@transcorpint.com",
                                        style: TextStyle(
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                         )
                        ],
                      ),
                      height20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(top: BorderSide(color: Colors.redAccent)),
                                borderRadius:
                                    BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.05),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              
                              child: Column(
                                children: [
                                  controller.menuItem(
                                    "Profile Details",
                                    "assets/profile-circle-svgrepo-com.svg",
                                    onTap: () {
                                      Get.toNamed('/profiledetails');
                                    },
                                  ),
                                  controller.menuItem(
                                    "Card Control",
                                    "assets/controller.svg",
                                    onTap: () {
                                      Get.toNamed('/managecard');
                                    },
                                  ),
                                  controller.menuItem(
                                    "Order New Card",
                                    "assets/credit-card-svgrepo-com.svg",
                                    onTap: () {
                                      Get.toNamed('/ordercard');
                                    },
                                  ),
                                  controller.menuItem(
                                      "FAQs", "assets/faq.svg"),
                                  controller.menuItem(
                                      "Privacy Policy",
                                      "assets/privacycom.svg"),
                                  controller.menuItem(
                                      "Terms & Conditions",
                                      "assets/condition&Terms.svg"),
                                  controller.menuItem(
                                      "Contact Support",
                                      "assets/contectsupport.svg"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            CustomButton(
                              text: "Logout",
                              prefixIcon: const Icon(Icons.logout,
                                  color: Colors.white),
                              btncolor: Colors.redAccent,
                              onPressed: () => controller
                                  .showLuxuryLogoutDialog(context),
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              "App version 2.4.66",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}