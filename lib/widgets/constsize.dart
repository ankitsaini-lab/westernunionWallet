 

import 'package:flutter/material.dart';
 

const SizedBox height2 = SizedBox(height: 2);
const SizedBox height4 = SizedBox(height: 4);
const SizedBox height6 = SizedBox(height: 6);
const SizedBox height8 = SizedBox(height: 8);
const SizedBox height10 = SizedBox(height: 10);
const SizedBox height12 = SizedBox(height: 12);
const SizedBox height16 = SizedBox(height: 16);
const SizedBox height20 = SizedBox(height: 20);
const SizedBox height24 = SizedBox(height: 24);
const SizedBox height32 = SizedBox(height: 32);
const SizedBox height40 = SizedBox(height: 40);

const SizedBox width2 = SizedBox(width: 2);
const SizedBox width4 = SizedBox(width: 4);
const SizedBox width6 = SizedBox(width: 6);
const SizedBox width8 = SizedBox(width: 8);
const SizedBox width10 = SizedBox(width: 10);
const SizedBox width12 = SizedBox(width: 12);
const SizedBox width16 = SizedBox(width: 16);
const SizedBox width20 = SizedBox(width: 20);
const SizedBox width24 = SizedBox(width: 24);
const SizedBox width32 = SizedBox(width: 32);

const SizedBox heightZero = SizedBox.shrink();
// void showCustomPopup(String message) {
//   bool isHtml = _containsHtml(message);

//   Get.dialog(
//     Dialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: isHtml
//               ? Html(
//                   data: message, // Renders HTML content
//                   style: {
//                     "html": Style(
//                       fontSize: FontSize(16),
//                       color: Colors.black,
//                     ),
//                   },
//                 )
//               : Text(
//                   message, // Renders plain text
//                   style: TextStyle(fontSize: 16, color: Colors.black),
//                 ),
//         ),
//       ),
//     ),
//   );
// }

// Helper function to check if a string contains HTML tags
// bool _containsHtml(String text) {
//   final htmlTagPattern =
//       RegExp(r'<[^>]*>'); // A simple regex to detect HTML tags
//   return htmlTagPattern.hasMatch(text);
// }