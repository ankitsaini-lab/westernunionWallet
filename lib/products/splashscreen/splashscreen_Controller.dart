import 'package:get/get.dart';

class SplashscreenController extends GetxController {
    void splash() async {

    try {
      // do {
      //   // token = await accessToken();

      //   await Future.delayed(const Duration(milliseconds: 250));
      // } 
      // while (token == null);

      await Future.delayed(const Duration(seconds: 3));

      // if (token.trim().isEmpty) {
        Get.offAllNamed('/login_singupview');
      // } else {
        // Get.offAllNamed('/dashboard');
      // }
    } catch (e) {
      // log("Error loading token: $e");
      // Get.offAllNamed('/login_singupview');
    }
  }

}