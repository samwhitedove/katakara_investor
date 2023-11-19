import 'package:get/get.dart';

class AppNotificationController extends GetxController {
  RxBool isOpened = false.obs;
  int currentOpened = -1.obs;
  openSelected(int selected) {
    if (currentOpened == selected) {
      isOpened.value = false;
      currentOpened = -1;
      update();
      return;
    }

    isOpened.value = true;
    currentOpened = selected;
    update();
  }
}
