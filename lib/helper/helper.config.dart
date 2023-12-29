import 'package:get_storage/get_storage.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/services/service.notification.dart';

import '../values/strings.dart';

class Config {
  static bool? isNew;

  static GetStorage? notificationStorage;
  static GetStorage? imageStorage;
  static GetStorage? configStorage;

  static initConfig() async {
    // loads the configuration storage
    configStorage = await AppStorage.initStorage(
        storageName: StorageNames.configStorage.name);
    // loads the uploaded image that is saved in the local storage
    imageStorage = await AppStorage.initStorage(
        storageName: StorageNames.imageStorage.name);
    // await AppStorage.deleteStorage(storageName: StorageNames.config.name);
    notificationStorage = await AppStorage.initStorage(
        storageName: StorageNames.notificationStorage.name);
    final _ = NotificationLocalStorageService();
    // read if is a new user
    await readConfig(StorageKeys.isNewUser, StorageNames.configStorage);
    // read if is a new user
    await readConfig(StorageKeys.isNewUser, StorageNames.configStorage);
    // read all local saved image
    await readConfig(StorageKeys.uploadUrls, StorageNames.configStorage);
  }

  static clearImageUrls() {
    AppStorage.saveData(
      storageName: StorageNames.imageStorage.name,
      key: StorageKeys.uploadUrls.name,
      value: <String>[],
    );
  }

  static clearImageStorage() async {
    final images = await AppStorage.saveData(
          key: StorageKeys.uploadUrls.name,
          storageName: StorageNames.imageStorage.name,
          value: <String>[],
        ) ??
        <String>[];
    HC.clearImages(images);
  }

  static Future<dynamic> readConfig(StorageKeys key, StorageNames name) async {
    switch (key) {
      case StorageKeys.isNewUser:
        isNew =
            await AppStorage.readData(storageName: name.name, key: key.name) ??
                true;
      case StorageKeys.uploadUrls:
        dynamic imageUrl =
            await AppStorage.readData(storageName: name.name, key: key.name);

        if (imageUrl != null && imageUrl.isNotEmpty) {
          return clearImageStorage();
        }
        break;
      default:
        break;
    }
  }

  static void saveConfig(
      {required bool value,
      required StorageKeys key,
      required StorageNames name}) async {
    await AppStorage.saveData(
      storageName: name.name,
      key: key.name,
      value: value,
    );
  }

  static void resetConfig(
      {required StorageKeys key, required StorageNames name}) async {
    await AppStorage.removeData(
      storageName: name.name,
      key: key.name,
    );
  }
}
