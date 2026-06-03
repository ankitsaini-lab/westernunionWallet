import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdercardController extends GetxController {
  var amount = 150.obs;

  var activeCardIndex = 0.obs;

  final List<Map<String, dynamic>> cardStyles = [
    {
      "name": "Obsidian Black",
      "colors": [const Color(0xFF111111), const Color(0xFF2C2C2C), const Color(0xFF151515)],
      "glowColor": const Color(0xFFE53935),
      "label": "Obsidian Limited",
      "textColor": Colors.white,
      "subColor": Colors.white70,
    },
    {
      "name": "Crimson Spark",
      "colors": [const Color(0xFFB71C1C), const Color(0xFFD32F2F), const Color(0xFFFF5252)],
      "glowColor": const Color(0xFFFFD54F),
      "label": "Crimson Elite",
      "textColor": Colors.white,
      "subColor": Colors.white70,
    },
    {
      "name": "Emerald Neon",
      "colors": [const Color(0xFF004D40), const Color(0xFF00695C), const Color(0xFF00897B)],
      "glowColor": const Color(0xFF00E676),
      "label": "Emerald Premium",
      "textColor": Colors.white,
      "subColor": Colors.white70,
    }
  ];
}