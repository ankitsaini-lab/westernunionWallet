import 'package:get/get.dart';

class SplashscreenController extends GetxController {
    void splash() async {

    try {
      
      

      
      
      

      await Future.delayed(const Duration(seconds: 3));

      
        Get.offAllNamed('/login_singupview');
      
        
      
    } catch (e) {
      
      
    }
  }

}