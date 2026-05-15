import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  var notifications = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.addAll([
      {
        "title": "Order Confirmed",
        "message": "Your order has been placed successfully.",
        "time": "2 min ago",
        "read": "false",
      },
      {
        "title": "New Offer",
        "message": "Get 20% off on your next purchase.",
        "time": "10 min ago",
        "read": "false",
      },
      {
        "title": "Delivery Update",
        "message": "Your package is out for delivery.",
        "time": "1 hour ago",
        "read": "false",
      },
    ]);
  }

  
  void markAsRead(int index) {
    notifications[index]["read"] = "true";
    notifications.refresh();
  }

   
  void clearAll() {
    notifications.clear();
  }
  Widget notificationCard(
  Map<String, String> item,
) {
  final bool isRead = item["read"] == "true";

  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 6,
    ),

    padding: const EdgeInsets.all(14),

    decoration: BoxDecoration(
      color: isRead
          ? Colors.grey.shade100
          : Colors.white,

      borderRadius: BorderRadius.circular(16),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),

    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        /// 🔔 Icon
        Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: isRead
                ? Colors.grey.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),

            shape: BoxShape.circle,
          ),

          child: Icon(
            Icons.notifications,

            color: isRead
                ? Colors.grey
                : Colors.red,
          ),
        ),

        const SizedBox(width: 12),

        /// 📝 Content
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                item["title"] ?? "",

                style: TextStyle(
                  fontWeight: isRead
                      ? FontWeight.w500
                      : FontWeight.w700,

                  fontSize: 14,

                  color: isRead
                      ? Colors.grey
                      : Colors.black,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                item["message"] ?? "",

                style: TextStyle(
                  fontSize: 12,
                  height: 1.4,

                  color: isRead
                      ? Colors.grey
                      : Colors.black54,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 13,
                    color: Colors.grey,
                  ),

                  const SizedBox(width: 4),

                  Text(
                    item["time"] ?? "",

                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),

                  const Spacer(),

                  if (isRead)
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.green
                            .withOpacity(0.1),

                        borderRadius:
                            BorderRadius.circular(20),
                      ),

                      child: const Text(
                        "Read",

                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ), 
        ),
      ],
    ),
  );
}
}