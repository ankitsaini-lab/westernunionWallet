import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Manage%20Card/managecard_Controller.dart';
import 'package:transwallet/widgets/custombutton.dart';
class ManagecardView
    extends GetView<ManagecardController> {
  const ManagecardView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() =>ManagecardController() ,);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,

        leadingWidth: 70,

        leading: Padding(
          padding: const EdgeInsets.only(left: 18),

          child: GestureDetector(
            onTap: Get.back,

            child: const Icon(
              Icons.arrow_back,
              
              color: Colors.black,
            ),
          ),
        ),

        title: const Text(
          "Manage Card",

          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),

          children: [
        
            controller.cardPreview(),

            const SizedBox(height: 24),

 
            Obx(
              () => GestureDetector(
                onTap:
                    controller.showBlockUnblockDialog,

                child: AnimatedContainer(
                  duration:
                      const Duration(milliseconds: 250),

                  height: 45,

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(14),

                    border: Border.all(
                      color:
                          controller.isCardBlocked.value
                              ? Colors.green
                              : const Color(
                                  0xFF111111,
                                ),

                      width: 1.4,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(.04),

                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),

                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [
                      Icon(
                        controller.isCardBlocked.value
                            ? Icons.lock_open_rounded
                            : Icons.lock_outline_rounded,

                        size: 20,

                        color:
                            controller.isCardBlocked.value
                                ? Colors.green
                                : const Color(
                                    0xFF111111,
                                  ),
                      ),

                      const SizedBox(width: 12),

                      Text(
                        controller.isCardBlocked.value
                            ? "Unblock Card"
                            : "Block Card",

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,

                          color:
                              controller
                                      .isCardBlocked
                                      .value
                                  ? Colors.green
                                  : const Color(
                                      0xFF111111,
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Transaction Configurations",
                
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                
              ],
            ),

            const SizedBox(height: 18),

           
            featureTile("ATM", controller.atm),

            featureTile("POS", controller.pos),

            featureTile("ECOM", controller.ecom),

            featureTile(
              "International",
              controller.international,
            ),

            featureTile("DCC", controller.dcc),

            featureTile(
              "Contactless",
              controller.contactless,
            ),

            const SizedBox(height: 20),
             CustomButton(text: "Save",textsize: 16, btncolor: Colors.black,   onPressed: () {
                    
                  },),
          ],
        ),
      ),
    );
  }
}