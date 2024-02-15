import 'dart:developer';

import 'package:get/get.dart';
import 'package:katakara_investor/services/service.notification.dart';
import 'package:katakara_investor/models/notifications/notification.model.dart';

class AppNotificationController extends GetxController {
  RxBool isOpened = false.obs;
  int currentOpened = -1.obs;

  List<NotificationAlertModel> notification = <NotificationAlertModel>[];

  @override
  onInit() async {
    super.onInit();
    await fetchNotification();
  }

  int page = 1;
  bool hasFullFetch = true;

  fetchNotification() async {
    await fetchMoreNotification();
  }

  addNotificationToLocalStrorage(NotificationAlertModel message) async {
    await NotificationLocalStorageService.saveNotification(message.toJson());
    await fetchMoreNotification(messageItem: message);
  }

  fetchMoreNotification(
      {NotificationAlertModel? messageItem, int limit = 10}) async {
    // if it is updaing the notification due to notification received
    // add the new notification received to the notification without fetching
    // all other notification from the local sttorage
    if (messageItem != null) {
      notification.insert(0, messageItem);
      update();
      return;
    }
    // Load from the local storage
    List<Map<String, dynamic>> fetchedNotifications =
        await NotificationLocalStorageService.fetchNotification(
      limit: limit,
      page: page,
    );
    if (fetchedNotifications.isEmpty) return;
    // clear the notification is the getched page is 1
    if (page == 1) {
      notification.clear();
      for (Map<String, dynamic> item in fetchedNotifications) {
        notification.add(NotificationAlertModel().toClassObject(item));
      }
      if (notification.length == limit) page += 1;
      update();
      return;
    }
    log('$page pages --------- fatching notifications -------------');
    // Prepare the new incoming data to be added if the lenght is full
    // remove the previous old data if the lenght is not full.
    if (hasFullFetch == false) {
      notification.removeRange(limit * (page - 1), notification.length - 1);
    }
    // will onlyy increase page if the current page data is complete the limit required
    if (fetchedNotifications.length == limit) {
      page += 1;
      hasFullFetch = true;
    } else {
      hasFullFetch = false;
    }
    for (Map<String, dynamic> item in fetchedNotifications) {
      notification.add(NotificationAlertModel().toClassObject(item));
    }
    update();
  }

  _updateStorageData(NotificationAlertModel item) async {
    log('${item.toJson()}--------------item');
    NotificationLocalStorageService.updateSingleNotification(item);
  }

  openSelected(int selected) {
    if (notification[selected].isRead == false) {
      notification[selected].isRead = true;
      _updateStorageData(notification[selected]);
    }

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
