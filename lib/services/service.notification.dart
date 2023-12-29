import 'dart:developer';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/notificatons/notification.local.model.dart';
import 'package:katakara_investor/models/notificatons/notification.model.dart';
import 'package:katakara_investor/values/strings.dart';
import 'package:katakara_investor/view/home/home.dart';

class NotificationLocalStorageService {
  NotificationLocalStorageService._internal();

  static final NotificationLocalStorageService _instance =
      NotificationLocalStorageService._internal();

  static final LocalNotificationModel _notifications =
      LocalNotificationModel(count: 0, data: <Datum>[]);

  factory NotificationLocalStorageService() {
    _readNotification();
    return _instance;
  }

  static get notificationCount => _notifications.count;

  static Future<void> saveNotification(Map<String, dynamic> model) async {
    try {
      Map<String, dynamic> save;
      if (_notifications.data!.isEmpty) {
        save = {
          "count": _notifications.count! + 1,
          "data": [model]
        };
      } else {
        save = {
          "count": _notifications.count! + 1,
          "data": [model, ..._notifications.data!.map((e) => e.toJson())]
        };
      }
      await AppStorage.saveData(
        storageName: StorageNames.notificationStorage.name,
        key: StorageKeys.notifications.name,
        value: save,
      );
      log("$model ------- New notifications Added ----------");
      //refresh the homepage to show notification
      Get.find<HomeScreenController>().update();
      await _readNotification();
    } catch (e) {
      log("$e ------- Error saving notifications ----------");
    }
  }

  static Future<bool> updateSingleNotification(
      NotificationAlertModel model) async {
    try {
      //Fetch all the data in the storage
      final Map<String, dynamic> data = await AppStorage.readData(
            storageName: StorageNames.notificationStorage.name,
            key: StorageKeys.notifications.name,
          ) ??
          <Map<String, dynamic>>{};
      // log('${data['data'].length} lenght read -------- ');
      LocalNotificationModel local = LocalNotificationModel.fromJson(data);
      if (local.data!.isEmpty) return true;
      // find the index of the data to update
      // log('action 1 -------- ');
      final index = local.data!
          .indexWhere((element) => element.hashedCode == model.hashedCode);
      if (index != -1) {
        // log('action 2 -------- ');
        //remove the data
        local.data!.removeAt(index);
        // add the updated value of the data
        // log('action 3 -------- ');
        local.data!.insert(index, Datum.fromJson(model.toJson()));
        //remove all the data from the storage
        // log('action 4 -------- ');
        await AppStorage.removeData(
            storageName: StorageNames.notificationStorage.name,
            key: StorageKeys.notifications.name);
        // add all the data from the storage back to the storage.
        // log('action 5 -------- ');
        await AppStorage.saveData(
            storageName: StorageNames.notificationStorage.name,
            key: StorageKeys.notifications.name,
            value: {
              "count": _notifications.count! - 1,
              "data": local.data!.map((e) => e.toJson()).toList()
            });
        // log('action done -------- ');
        _readNotification();
        //refresh the homepage to show notification
        Get.find<HomeScreenController>().update();
        return true;
      }

      return false;
    } catch (e) {
      log("$e ------- Error saving notifications ----------");
      return false;
    }
  }

  //read all notification when starting app
  static Future<void> _readNotification() async {
    log("Class has been initialized ------------------------ ");
    final Map<String, dynamic> notifies = await AppStorage.readData(
          storageName: StorageNames.notificationStorage.name,
          key: StorageKeys.notifications.name,
        ) ??
        <Map<String, dynamic>>{};
    LocalNotificationModel local = LocalNotificationModel.fromJson(notifies);
    _notifications.data!.clear();
    _notifications.count = local.count!;
    _notifications.data = local.data!;
    log('${_notifications.toJson()} loaded ----- notifications');
  }

  static Future<List<Map<String, dynamic>>> fetchNotification(
      {int limit = 10, int page = 1}) async {
    log("${_notifications.data!.length} ------- fetch data from notification ----------");
    if (_notifications.data!.isEmpty) return [];
    final List<Datum> data = _notifications.data!
        .skip(page == 1 ? 0 : limit * (page - 1))
        .take(limit)
        .toList();
    // log("$data ------- fetch data ----------");
    log("${data.length} ------- notification fetched ----------");
    return data.map((e) => e.toJson()).toList();
  }

  // static Future<void> clearNotifications() async {
  //   await AppStorage.deleteStorage(
  //       storageName: StorageNames.notificationStorage.name);
  //   log("------- storage deleted ----------");
  // }
}
