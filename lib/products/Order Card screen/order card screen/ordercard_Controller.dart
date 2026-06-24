import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdercardController extends GetxController {
  var amount = 150.obs;

  var activeCardIndex = 0.obs;

  final List<Map<String, dynamic>> cardStyles = [
    {
      "name": "Obsidian Black",
      "colors": [const Color(0xFF111111), const Color(0xFF2C2C2C), const Color(0xFF151515)],
      "glowColor": const Color(0xFFFFCC00),
      "label": "Obsidian Limited",
      "textColor": Colors.white,
      "subColor": Colors.white70,
    },
    {
      "name": "Amber Gold",
      "colors": [const Color(0xFFFFCC00), const Color(0xFFFFB300), const Color(0xFFFF8F00)],
      "glowColor": const Color(0xFFFFB300),
      "label": "Gold Elite",
      "textColor": const Color(0xFF111111),
      "subColor": const Color(0xFF4B5563),
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