import 'package:katakara_investor/helper/helper.dart';

import '../values/strings.dart';

class Config {
  static bool? isNew;

  static initConfig() async {
    // loads the configuration storage
    await AppStorage.initStorage(storageName: StorageNames.configStorage.name);
    // loads the uploaded image that is saved in the local storage
    await AppStorage.initStorage(storageName: StorageNames.imageStorage.name);
    // await AppStorage.deleteStorage(storageName: StorageNames.config.name);
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
