import 'dart:developer';

import 'package:katakara_investor/helper/helper.local.storage.dart';
import 'package:katakara_investor/models/register/register.dart';
import 'package:katakara_investor/values/values.dart';

class AppSettings {
  static bool? isLogin;

  static init() async {
    await AppStorage.initStorage(
        storageName: StorageNames.settingsStorage.name);
    final userInfo = await AppStorage.readData(
        storageName: StorageNames.settingsStorage.name,
        key: SettingsKey.user.name);
    if (userInfo != null) {
      userData = UserDataModel.fromJson(userInfo);
      // log("user info::  $userInfo");
      isLogin = await AppStorage.readData(
            storageName: StorageNames.settingsStorage.name,
            key: SettingsKey.isLogin.name,
          ) ??
          false;
    }
  }

  static updateLocalUserData(Map<String, dynamic> body) async {
    log("Updating local data");
    final data = userData.toJson();
    data.updateAll((key, value) => body[key] ?? value);
    final newData = await saveUserToLocal(data);
    log("After save data ------- $newData");
  }

  static saveUserToLocal(Map<String, dynamic> value) async {
    userData = UserDataModel.fromJson(value);
    log('${userData.toJson()} --------- user data local');
    await AppStorage.saveData(
      storageName: StorageNames.settingsStorage.name,
      key: SettingsKey.user.name,
      value: value,
    );
    return await AppStorage.readData(
        storageName: StorageNames.settingsStorage.name,
        key: SettingsKey.user.name);
  }

  static addUploadedImageUrlToStorage({
    required String value,
  }) async {
    List<dynamic> data = await AppStorage.readData(
            storageName: StorageNames.imageStorage.name,
            key: StorageKeys.uploadUrls.name) ??
        <String>[];
    AppStorage.saveData(
        storageName: StorageNames.imageStorage.name,
        key: StorageKeys.uploadUrls.name,
        value: [...(data..add(value))]);
  }

  static removeUploadeImageUrlFromStorage({
    required String value,
  }) async {
    final List<dynamic> data = await AppStorage.readData(
            storageName: StorageNames.imageStorage.name,
            key: StorageKeys.uploadUrls.name) ??
        <String>[];
    if (data.isEmpty) return;
    data.remove(value);
    AppStorage.saveData(
        storageName: StorageNames.imageStorage.name,
        key: StorageKeys.uploadUrls.name,
        value: [...data]);
  }

  static saveAppState(Map<String, dynamic> value, LocalStateName key) async {
    log("saving local data");
    await AppStorage.saveData(
      storageName: StorageNames.appState.name,
      value: value,
      key: key.name,
    );
  }

  static removeAppState(Map<String, dynamic> value, LocalStateName key) async {
    log("removing local data");
    AppStorage.saveData(
      storageName: StorageNames.appState.name,
      value: value,
      key: key.name,
    );
  }

  static getAppState(LocalStateName key) async {
    log("getting local data");
    return await AppStorage.readData(
      storageName: StorageNames.appState.name,
      key: key.name,
    );
  }
}
