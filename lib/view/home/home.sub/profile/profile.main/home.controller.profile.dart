import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/models/register/register.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/services/services.dart';
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
  String? hasVehicle;
  String? bankName;

  RxBool showPassword = false.obs;
  RxBool canUpdatePassword = false.obs;

  checkIsValidToSave() {
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
    hasVehicle = userData.ownVehicle;
    signature = userData.investorSignature ?? "";
    bankName = userData.bankName!;
    if (signature.isNotEmpty) hasUploadSignature(true);
    super.onInit();
  }

  String signature = "";

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
          "onTap": () => Get.toNamed(AppRoutes.name(RouteName.userDetails))
        },
        {
          'label': "Business Details",
          'icon': Assets.assetsSvgBriefcase,
          "onTap": () => Get.toNamed(AppRoutes.name(RouteName.userBusiness))
        },
        {
          'label': "Bank Details",
          'icon': Assets.assetsSvgBank,
          "onTap": () => Get.toNamed(AppRoutes.name(RouteName.userBank))
        },
        {
          'label': "Security",
          'icon': Assets.assetsSvgSecurity,
          "onTap": () => Get.toNamed(AppRoutes.name(RouteName.userSecurity))
        },
        {'label': "Log Out", 'icon': Assets.assetsSvgLogout, "onTap": logOut}
      ];

  savePassword() async {
    HC.hideKeyBoard();
    isSavingSecurity(true);
    update();
    final RequestResponsModel model = await MyRequestClass.krequest(
        endPoint: EndPoint.changeUserPassword,
        method: Methods.patch,
        body: {
          "newPassword": newPassword.text,
          "oldPassword": oldPassword.text,
        });
    if (model.statusCode == 200) {
      HC.snack(model.message, success: model.success);
      await signOut();
      isSavingSecurity(false);
      return Get.offAllNamed(AppRoutes.name(RouteName.login));
    }

    HC.snack(model.message, success: model.success);

    isSavingSecurity(false);
    update();
  }

  logOut() {
    Get.bottomSheet(
      Container(
        height: Get.height * .25,
        child: Column(
          children: [
            Text(tAreuSure)
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  deleteSignaure() async {
    log('start');
    try {
      return CW.bottomSheet(title: "Are you sure to delete signature?", data: [
        {
          'label': "Yes",
          "onTap": () async {
            Get.back();
            isSavingCompanyDetails(true);
            update();
            MyRequestClass.deleteRequest(
                url: signature, endPoint: EndPoint.deleteImage);
            await MyRequestClass.krequest(
                method: Methods.patch,
                body: {'investorSignature': null},
                endPoint: EndPoint.updateProfile);
            signature = '';
            await Services.fetchUser();
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

  signOut() async {
    isLoading.value = true;
    update();
    Get.back();
    AppStorage.deleteStorage(storageName: StorageNames.settings.name);
    await MyRequestClass.krequest(
        endPoint: EndPoint.goLiveAndOffline,
        body: {"status": false},
        method: Methods.patch);
    await Config.deleteAllLocalUnuseImage();
    userData = UserDataModel();
    MyRequestClass.krequest(endPoint: EndPoint.logOut, method: Methods.get);
    Config.clearImageUrls();
    MyRequestClass.cancelAllConnection();
    Get.offAllNamed(AppRoutes.name(RouteName.login));
    isLoading.value = false;
  }

  changeProfileImage(controllerInstance) async {
    try {
      Map<String, dynamic> pickedImage =
          await HC.pickAndCheckImage(ImageSource.gallery);
      if (pickedImage['hasImage']) {
        isUploadingImage(true);
        RequestResponsModel response =
            await MyRequestClass.uploadImageWithToken(
                filePath: pickedImage['image'],
                endpoint: EndPoint.updateProfileImage,
                imageUploadType: UploadType.Profile,
                fileType: pickedImage['mime'] == 'pdf'
                    ? ImageType.PDF
                    : ImageType.IMAGE,
                controller: controllerInstance);
        log(response.toJson().toString() + "--------");
        userData.profileImageUrl = response.data['downloadUrl'];
        log(userData.toJson().toString());
        await Services.fetchUser();
        Config.clearImageUrls();
        isUploadingImage(false);
        update();
      }
    } catch (e) {
      isUploadingImage(false);
    }
  }

  saveUserInfo(Map<String, dynamic> body, {int page = 1}) async {
    try {
      bool canUpdate;
      switch (page) {
        case 1:
          canUpdate = userData.fullName!.trim() == fulName.text.trim() &&
              userData.phoneNumber!.trim() == phone.text.trim() &&
              userData.phoneNumber2!.trim() == phone2.text.trim();
          break;
        case 2:
          canUpdate = userData.address!.trim() == fullAdress.text.trim() &&
              userData.companyName!.trim() == company.text.trim() &&
              userData.ownVehicle!.trim() == hasVehicle?.trim();
          break;
        case 3:
          canUpdate = userData.bankName!.trim() == bankName!.trim() &&
              userData.accountName!.trim() == accountName.text.trim() &&
              userData.accountNumber!.trim() == accountNumber.text.trim();
          break;
        default:
          canUpdate = false;
      }

      if (!canUpdate) {
        if (page == 1) isLoading(true);
        if (page == 2) isSavingCompanyDetails(true);
        if (page == 3) isSavingBankDetails(true);
        update();
        RequestResponsModel response = await MyRequestClass.krequest(
            endPoint: EndPoint.updateProfile,
            body: body,
            method: Methods.patch);
        if (response.success) {
          isLoading(false);
          await Services.fetchUser();
          if (page == 1) isLoading(false);
          if (page == 2) isSavingCompanyDetails(false);
          if (page == 3) isSavingBankDetails(false);

          update();
          return HC.snack("profile Updated Successful", success: true);
        }
        if (page == 1) isLoading(false);
        if (page == 2) isSavingCompanyDetails(false);
        if (page == 3) isSavingBankDetails(false);

        update();
      }
      return HC.snack('No changes for update');
    } catch (e) {
      if (page == 1) isLoading(false);
      if (page == 2) isSavingCompanyDetails(false);
      if (page == 3) isSavingBankDetails(false);
    }
  }

  uploadImage({required type, required ProfileController controller}) async {
    //type is the folder name where the file is going to be store in the database
    //idType is the type of image they re uploading to know which to check for.
    File? pickedImage = await HC.pickImage(ImageSource.gallery);
    if (pickedImage == null) return null;
    final croppedImage = await HC.cropImage(pickedImage);
    if (croppedImage == null) return null;
    int imageSize = await croppedImage.stat()!.then((value) => value.size);
    log(imageSize.toString());
    if (imageSize > 5000000) return HC.snack("File too big to upload");
    String mimitype =
        croppedImage.path.split('/').last.split('.').last.toLowerCase();
    log(mimitype);
    isUploadingSignature(true);
    update();
    log('starting upload $croppedImage');
    RequestResponsModel response = await MyRequestClass.uploadImageWithToken(
        filePath: croppedImage,
        endpoint: EndPoint.updateInvestorSignature,
        fileType: mimitype == 'pdf' ? ImageType.PDF : ImageType.IMAGE,
        controller: controller);
    log(response.toJson().toString() + '-----response');
    log(response.statusCode.toString() + '-----staus');
    log((response.statusCode == 200).toString() + '-----check code response');
    if (response.statusCode == 200) {
      signature = response.data['downloadUrl'];
      hasUploadSignature(true);
      isUploadingSignature(false);
      await Services.fetchUser();
      HC.snack(response.message, success: response.success);
      update();
      return;
    }
    HC.snack(response.message);
    isUploadingSignature(false);
    update();
  }
}
