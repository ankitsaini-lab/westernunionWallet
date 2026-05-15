import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/History%20screen/historyscreen_Controller.dart';
import 'package:transwallet/widgets/globalbottombar/Globalbottombar_View.dart';
class HistoryscreenView extends GetView<HistoryscreenController> {
  const HistoryscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<HistoryscreenController>()) {
      Get.lazyPut(() => HistoryscreenController());
    }

    const primaryRed = Color(0xFFD64550);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      bottomNavigationBar: GlobalbottombarView(seletedIndex: 2.obs),
      appBar: AppBar(
        leading: GestureDetector(
onTap: () {
  Get.back();
  
},
child: Icon(Icons.arrow_back,color: Colors.transparent,),
        ),
        title: const Text(
          "All Transactions",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 18),
        ),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black)),
          IconButton(
            onPressed: () {}, 
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: primaryRed.withOpacity(0.1),
                shape: BoxShape.circle
              ),
              child: const Icon(Icons.calendar_today_outlined, color: primaryRed, size: 20)
            )
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          physics: const BouncingScrollPhysics(),
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final tx = controller.transactions[index];
            return controller.transactionCard(tx);
          },
        ),
      ),
    );
  }
}
