import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.profile.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/services/services.auth.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';
import '../../../../../helper/helper.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSavingCompanyDetails = false.obs;
  RxBool isSavingBankDetails = false.obs;
  RxBool isSavingSecurity = false.obs;
  RxDouble uploadProgress = 0.0.obs;
  RxBool isUploadingImage = false.obs;
  HomeScreenController? homeScreenController;
  String hasVehicle = userData.ownVehicle ?? "No";
  String? bankName;

  RxBool showPassword = false.obs;
  RxBool canUpdatePassword = false.obs;

  final profileService = Get.find<ProfileService>();

  checkPasswordIsValidToSave() {
    log(HC.validatePasswordStrength(newPassword.text)['status'].toString());
    log(oldPassword.text.isNotEmpty.toString());
    log((newPassword.text == confirmPassword.text).toString());
    canUpdatePassword.value = newPassword.text == confirmPassword.text &&
        HC.validatePasswordStrength(newPassword.text)['status'] &&
        oldPassword.text.isNotEmpty;
  }

  checkPassword() {
    final check = newPassword.text == confirmPassword.text;
    if (check) return null;
    return "password did not match";
  }

  changeHasVehicle(String value) {
    hasVehicle = value;
    update();
  }

  changeBankName(String value) {
    bankName = value;
    update();
  }

  RxBool isUploadingSignature = false.obs;
  RxBool hasUploadSignature = false.obs;
  RxBool isfetchingSignature = false.obs;

  @override
  void onInit() {
    log(userData.investorSignature.toString());
    bankName = userData.bankName ?? '';
    if ((userData.investorSignature ?? "").isNotEmpty &&
        (userData.investorSignature ?? "").length > 10) {
      hasUploadSignature(true);
    }
    super.onInit();
  }

  TextEditingController fulName =
      TextEditingController(text: userData.fullName);
  TextEditingController email = TextEditingController(text: userData.email);
  TextEditingController phone =
      TextEditingController(text: userData.phoneNumber);
  TextEditingController phone2 = TextEditingController(
      text: userData.phoneNumber2 == 'null' ? '' : userData.phoneNumber2);
  TextEditingController company =
      TextEditingController(text: userData.companyName);
  TextEditingController fullAdress =
      TextEditingController(text: userData.address);
  TextEditingController accountNumber =
      TextEditingController(text: userData.accountNumber);
  TextEditingController accountName =
      TextEditingController(text: userData.accountName);
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  List<Map<String, dynamic>> menuData() => [
        {
          'label': "User Details",
          'icon': Assets.assetsSvgProfileActive,
          "onTap": () => Get.toNamed(RouteName.userDetails.name)
        },
        {
          'label': "Business Details",
          'icon': Assets.assetsSvgBriefcase,
          "onTap": () => Get.toNamed(RouteName.userBusiness.name)
        },
        {
          'label': "Bank Details",
          'icon': Assets.assetsSvgBank,
          "onTap": () => Get.toNamed(RouteName.userBank.name)
        },
        {
          'label': "Security",
          'icon': Assets.assetsSvgSecurity,
          "onTap": () => Get.toNamed(RouteName.userSecurity.name)
        },
        {
          'label': "Admin",
          'icon': Assets.assetsSvgSecurity,
          "onTap": () => Get.toNamed(RouteName.admin.name)
        },
        {'label': "Log Out", 'icon': Assets.assetsSvgLogout, "onTap": logOut}
      ];

  // CHECK DONE
  updateBusinessDetails() async {
    HC.hideKeyBoard();
    final bool canUpdate = userData.address!.trim() == fullAdress.text.trim() &&
        userData.companyName!.trim() == company.text.trim() &&
        userData.ownVehicle == hasVehicle;

    if (canUpdate) return HC.snack('No changes for update');
    isSavingCompanyDetails(true);
    update();
    RequestResponseModel response =
        await profileService.updateUserInformation(data: {
      "companyName": company.text,
      "ownVehicle": hasVehicle,
      "address": fulName.text.trim()
    });

    HC.snack(response.message, success: response.success);
    isSavingCompanyDetails(false);
    update();
  }

  // CHECK DONE
  updateBankDetails() async {
    HC.hideKeyBoard();
    final bool canUpdate = userData.bankName!.trim() == bankName!.trim() &&
        userData.accountName!.trim() == accountName.text.trim() &&
        userData.accountNumber == accountNumber.text.trim();

    if (canUpdate) return HC.snack('No changes for update');
    isSavingBankDetails(true);
    update();
    RequestResponseModel response =
        await profileService.updateUserInformation(data: {
      "bankName": bankName,
      "accountName": accountName.text,
      "accountNumber": accountNumber.text,
    });

    HC.snack(response.message, success: response.success);
    isSavingBankDetails(false);
    update();
  }

  // CHECK DONE
  deleteSignaure() async {
    try {
      return CW.bottomSheet(title: "Are you sure to delete signature?", data: [
        {
          'label': "Yes",
          "onTap": () async {
            Get.back();
            isSavingCompanyDetails(true);
            update();
            await profileService.deleteImage(
                url: userData.investorSignature,
                fieldToUpdate: "investorSignature");
            hasUploadSignature(false);
            isSavingCompanyDetails(false);
            update();
          },
          'color': AppColor.red
        },
        {'label': "No", 'onTap': () => Get.back()}
      ]);
    } catch (e) {
      log(e.toString());
    }
  }

  // CHECK DONE
  uploadSignature() async {
    try {
      Map<String, dynamic> pickedImage =
          await HC.pickAndCheckImage(ImageSource.gallery);
      if (pickedImage['hasImage']) {
        final File image = await HC.cropImage(pickedImage['image']);
        if (image.path.length < 3) return;
        isUploadingImage(true);
        isSavingCompanyDetails(true);
        update();

        final imageUrl = await profileService.updateImagesAndDocs(
          controller: this,
          pickedImage: image,
          fieldToUpdate: 'investorSignature',
          previousUrl: userData.investorSignature,
          shouldUpdateLocal: true,
        );

        if (imageUrl.success) {
          log(userData.investorSignature.toString());
          userData.investorSignature = imageUrl.data;
          hasUploadSignature(true);
          update();
        }
      }
      isSavingCompanyDetails(false);
      isUploadingImage(false);
    } catch (e) {
      isUploadingImage(false);
    }
  }

  // CHECK DONE
  updateProfileDetails() async {
    HC.hideKeyBoard();
    final bool canUpdate = userData.fullName!.trim() == fulName.text.trim() &&
        userData.phoneNumber!.trim() == phone.text.trim() &&
        userData.phoneNumber2!.trim() == phone2.text.trim();

    if (canUpdate) return HC.snack('No changes for update');
    isLoading(true);
    update();
    RequestResponseModel response =
        await profileService.updateUserInformation(data: {
      "phoneNumber": phone.text.trim(),
      "phoneNumber2": phone2.text.trim().isEmpty ? "null" : phone2.text.trim(),
      "fullName": fulName.text.trim()
    });
    HC.snack(response.message, success: response.success);
    isLoading(false);
    update();
  }

  // CHECK DONE
  savePassword() async {
    HC.hideKeyBoard();
    isSavingSecurity(true);
    update();
    final RequestResponseModel model =
        await profileService.changePassword(data: {
      "newPassword": newPassword.text,
      "oldPassword": oldPassword.text,
    });
    if (model.statusCode == 200) {
      HC.snack(model.message, success: model.success);
      await signOut();
      isSavingSecurity(false);
      return Get.offAllNamed(RouteName.login.name);
    }

    HC.snack(model.message, success: model.success);

    isSavingSecurity(false);
    update();
  }

  // CHECK DONE
  changeProfileImage() async {
    try {
      Map<String, dynamic> pickedImage =
          await HC.pickAndCheckImage(ImageSource.gallery);
      if (pickedImage['hasImage']) {
        isUploadingImage(true);
        await profileService.updateImagesAndDocs(
            controller: this,
            pickedImage: pickedImage['image'],
            fieldToUpdate: 'profileImageUrl',
            previousUrl: userData.profileImageUrl);
        isUploadingImage(false);
        update();
      }
      isUploadingImage(false);
    } catch (e) {
      isUploadingImage(false);
    }
  }

  logOut() {
    Get.bottomSheet(
      SizedBox(
        height: Get.height * .25,
        child: Column(
          children: [
            const Text(tAreuSure)
                .title(fontSize: 14, color: AppColor.text)
                .addPaddingVertical(size: 15),
            CW
                .button(onPress: signOut, text: tLogOut)
                .marginSymmetric(horizontal: 20),
            CW
                .button(onPress: Get.back, text: tCancel, color: AppColor.grey)
                .marginSymmetric(horizontal: 20),
          ],
        ),
      ),
      backgroundColor: AppColor.white,
      clipBehavior: Clip.none,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  signOut() async {
    isLoading.value = true;
    update();
    Get.back();
    AppStorage.deleteStorage(storageName: StorageNames.settingsStorage.name);
    Get.find<AuthService>().goLive({"status": false, "fcmToken": ""});
    Get.find<AuthService>().logOutUser();
    await Config.clearImageStorage();
    Config.clearImageUrls();
    MyRequestClass.cancelAllConnection();
    Get.offAllNamed(RouteName.login.name);
    isLoading.value = false;
  }

  clearData() async {
    AppStorage.deleteStorage(storageName: StorageNames.settingsStorage.name);
    await Config.clearImageStorage();
    MyRequestClass.cancelAllConnection();
    Get.offAllNamed(RouteName.login.name);
  }
}
