import 'package:get/get.dart';

import '../../auth/ui/controllers/auth_controller.dart';

class MainBottomNavBarController extends GetxController {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void moveToCategory() {
    changeIndex(1);
  }

  bool shouldNavigate(int index) {
    if (index == 2 || index == 3) {
      return Get.find<AuthController>().isValidUser();
    }
    return true;
  }

  void backToHome() {
    changeIndex(0);
  }
}
