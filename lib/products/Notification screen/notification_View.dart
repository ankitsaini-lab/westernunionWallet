import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Notification%20screen/notification_Controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

 @override
Widget build(BuildContext context) {
  Get.put(NotificationController()); 

  return Container(
    height: MediaQuery.of(context).size.height * 0.5,
    decoration: BoxDecoration(
      color: Color(0xFFF8F9FA),
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: Column(
      children: [
        
      
        SizedBox(height: 10),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () =>  Text(
                  "Notifications (${controller.notifications.length})",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              
            ],
          ),
        ),

        
        Expanded(
          child: Obx(() {
            if (controller.notifications.isEmpty) {
              return Center(child: Text("No Notifications"));
            }

            return ListView.builder(
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) {
                final item = controller.notifications[index];

                return Dismissible(
  key: ValueKey(
    item["title"]! + item["time"]!,
  ),

  direction: DismissDirection.endToStart,

  background: Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 6,
    ),
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(14),
    ),
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.symmetric(horizontal: 20),

    child: const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.done_all,
          color: Colors.white,
        ),

        SizedBox(width: 6),

        Text(
          "Mark as Read",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  ),

  
  confirmDismiss: (_) async {
    controller.markAsRead(index);

    
    
    

    
    
    

    
    
    

     
    return false;
  },

  child: controller. notificationCard(item),
);
              },
            );
          }),
        ),
      ],
    ),
  );

}
}