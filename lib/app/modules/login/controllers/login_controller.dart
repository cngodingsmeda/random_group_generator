import 'package:get/get.dart';
import 'package:random_group_generator/app/modules/home/views/home_view.dart';

class LoginController extends GetxController {
  // Controller logic for login
  
  void loginWithGoogle() {
    // Get.offAllNamed(Routes.ROLE);
  }

  void loginAsGuest() {
    Get.offAll(() => const HomeView());
  }
}
