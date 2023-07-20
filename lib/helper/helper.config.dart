import 'dart:developer';

import 'package:katakara_investor/services/service.endpoints.dart';

import '../services/service.http.dart';
import '../values/strings.dart';
import 'helper.local.storage.dart';

class Config {
  static bool? isNew;
  static bool? isLogin;

  static initConfig() async {
    await AppStorage.initStorage(storageName: StorageNames.config.name);
    await AppStorage.initStorage(storageName: StorageNames.uploads.name);
    // await AppStorage.deleteStorage(storageName: StorageNames.config.name);
    await readConfig(ConfigStorageKey.isNewUser);
    await readConfig(ConfigStorageKey.uploadUrls);
  }

  static clearImageUrls() {
    AppStorage.saveData(
        storageName: StorageNames.uploads.name,
        key: ConfigStorageKey.uploadUrls.name,
        value: []);
  }

  static deleteAllLocalUnuseImage() async {
    final allUrl = await AppStorage.readData(
        storageName: StorageNames.uploads.name,
        key: ConfigStorageKey.uploadUrls.name);
    if (allUrl.length != 0) {
      allUrl.forEach((e) {
        try {
          MyRequestClass.deleteRequest(url: e, endPoint: EndPoint.deleteImage);
        } catch (e) {
          log(e.toString());
        }
      });
      await AppStorage.saveData(
          key: ConfigStorageKey.uploadUrls.name,
          storageName: StorageNames.uploads.name,
          value: []);
    }
  }

  static Future<dynamic> readConfig(ConfigStorageKey key) async {
    switch (key) {
      case ConfigStorageKey.isNewUser:
        isNew = await AppStorage.readData(
                storageName: StorageNames.config.name,
                key: ConfigStorageKey.isNewUser.name) ??
            true;
      case ConfigStorageKey.uploadUrls:
        final allUrl = await AppStorage.readData(
            storageName: StorageNames.uploads.name,
            key: ConfigStorageKey.uploadUrls.name);

        if (allUrl == null) {
          AppStorage.saveData(
              storageName: StorageNames.uploads.name,
              key: ConfigStorageKey.uploadUrls.name,
              value: []);
          return;
        }
        deleteAllLocalUnuseImage();
        break;
      default:
        break;
    }
  }

  static void saveConfig(
      {required bool isNewUserValue, required ConfigStorageKey key}) async {
    await AppStorage.saveData(
      storageName: StorageNames.config.name,
      key: key.name,
      value: isNewUserValue,
    );
  }

  static void resetConfig({required ConfigStorageKey key}) async {
    await AppStorage.removeData(
      storageName: StorageNames.config.name,
      key: key.name,
    );
  }
}
