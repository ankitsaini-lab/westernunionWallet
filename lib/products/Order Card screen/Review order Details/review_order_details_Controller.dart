import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewOrderDetailsController extends GetxController {
   var amount = 150.obs;
   
   var nameController = TextEditingController();
   var name = ''.obs;

} Widget buildField({
    required String label,
    TextEditingController? controller,
    String? initialValue,
    bool enabled = true,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      enabled: enabled,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }