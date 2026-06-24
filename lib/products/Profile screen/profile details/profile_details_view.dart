import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Profile%20screen/profile%20details/profile_details_Controller.dart';
import 'package:transwallet/widgets/constsize.dart';

class ProfileDetailsView extends GetView<ProfileDetailsController> {
  const ProfileDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileDetailsController(),);
return Scaffold(
  backgroundColor: const Color(0xffF6F7FB),
  body: Column(
    children: [

      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 60,
          left: 20,
          right: 20,
          bottom: 30,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFCC00),
              Color(0xFFFFB300),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [

            Row(
              children: [

                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF111111),
                    ),
                  ),
                ),

                const Spacer(),

                const Text(
                  "Profile Detail",
                  style: TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const Spacer(),

                const SizedBox(width: 40),
              ],
            ),

            const SizedBox(height: 30),

            Obx(
              () => Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage(
                    controller.profileImage.value,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            Obx(
              () => Text(
                controller.name.value,
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 6),

            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified,size: 18,color: Color(0xFF111111),),
                  width4,
                  Text(
                    controller.accountverification.value,
                    style: TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              Obx(
                () => controller.buildTile(
                  icon: Icons.email_outlined,
                  title: "Email Address",
                  value: controller.email.value,
                ),
              ),

              Obx(
                () => controller.buildTile(
                  icon: Icons.call_outlined,
                  title: "Phone Number",
                  value: controller.phone.value,
                ),
              ),

              Obx(
                () => controller.buildTile(
                  icon: Icons.location_on_outlined,
                  title: "Address",
                  value: controller.address.value,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCC00).withOpacity(.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.support_agent,
                        color: Color(0xFF111111),
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Need Help?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "Contact our support team for quick help.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.snackbar(
                          "Support",
                          "Contact Support Clicked",
                          snackPosition:
                              SnackPosition.BOTTOM,
                          backgroundColor: const Color(0xFFFFCC00),
                          colorText: const Color(0xFF111111),
                          margin: const EdgeInsets.all(14),
                          borderRadius: 12,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFCC00),
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Contact",
                          style: TextStyle(
                            color: Color(0xFF111111),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
); 
  }
}