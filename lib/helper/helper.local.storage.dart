import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppStorage extends GetxService {
  static initStorage({required String storageName}) async {
    GetStorage box = GetStorage(storageName);
    bool inits = await box.initStorage;
    if (inits) {
      return log('$storageName successfully initialized');
    }
    return log('$storageName unable to initialized');
  }

  static deleteStorage({required String storageName}) async {
    final box = GetStorage(storageName);
    box.erase();
  }

  static saveData(
      {required String storageName,
      required String key,
      required dynamic value}) async {
    final box = GetStorage(storageName);
    box.write(key, value);
  }

  static removeData({required String storageName, required String key}) async {
    final box = GetStorage(storageName);
    box.remove(key);
  }

  static readData({required String storageName, required String key}) async {
    final box = GetStorage(storageName);
    final read = await box.read(key);
    log(read.toString());
    return read;
  }

  static listenToKeyChanges(
      {required GetStorage storageName,
      required String key,
      required Function action}) async {
    // final box = GetStorage(storageName);
    storageName.listenKey(key, (value) {
      log('new key is $value');
      action(value);
    });
  }

  static listenToStorage({required String storageName}) async {
    final box = GetStorage(storageName);
    box.listen(() {
      log('box changed $storageName');
    });
  }
}
