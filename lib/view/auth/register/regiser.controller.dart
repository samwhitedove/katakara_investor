import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/register/model.create.account.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class RegisterScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isValidCredentails = false.obs;
  RxBool isUploadingProfileImage = false.obs;
  RxBool isUploadingGovImage = false.obs;
  RxBool isUploadingLetterImage = false.obs;
  RxBool isUploadingCacImage = false.obs;
  RxBool hasRequestVerifyEmail = false.obs;
  RxBool hasVerifiedEmail = false.obs;
  RxBool hasValidEmail = false.obs;
  RxBool hasInputCode = false.obs;
  RxBool canSendEmailVerificationRequest = false.obs;
  RxDouble uploadProgress = .0.obs;
  GlobalKey createAccountFormKey = GlobalKey<FormState>();
  GlobalKey stepFormKey = GlobalKey<FormState>();
  GlobalKey step2FormKey = GlobalKey<FormState>();
  GlobalKey step3FormKey = GlobalKey<FormState>();

  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  Map<String, RxMap<String, bool>> steps = RxMap<String, RxMap<String, bool>>({
    "step1": RxMap<String, bool>({
      "isDone": false,
      "isActive": true,
      "hasData": false,
    }),
    "step2": RxMap<String, bool>({
      "isDone": false,
      "isActive": false,
      "hasData": false,
    }),
    "step3": RxMap<String, bool>({
      "isDone": false,
      "isActive": false,
      "hasData": false,
    }),
  });

  List<String> labels = [
    'Basic Information',
    'Investor Details',
    'ID Verification'
  ];

  RxInt time = 60.obs;
  Timer? _timer;

  startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (time.value != 1) {
        time.value -= 1;
        return;
      }

      time.value -= 1;
      _timer!.cancel();
      canSendEmailVerificationRequest.value = true;
      time.value = 60;
    });
  }

  dynamic checkMatchLoginPassword() {
    if (confirmPassword!.text.isEmpty) {
      return null;
    }

    if (confirmPassword!.text == password!.text) {
      return null;
    }
    return "Password didn't match.";
  }

  RxInt currentPage = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  TextEditingController? email;
  TextEditingController? password;
  TextEditingController? confirmPassword;
  TextEditingController? fullName;
  TextEditingController? companyName;
  TextEditingController? phoneNumber;
  TextEditingController? phoneNumber2;
  TextEditingController? accountName;
  TextEditingController? accountNumber;
  TextEditingController? fullAddress;
  TextEditingController? code;

  @override
  void onInit() {
    log('initializing');
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    fullName = TextEditingController();
    companyName = TextEditingController();
    phoneNumber = TextEditingController();
    phoneNumber2 = TextEditingController();
    accountName = TextEditingController();
    accountNumber = TextEditingController();
    fullAddress = TextEditingController();
    code = TextEditingController();
    log('initializing');
    super.onInit();
  }

  RxString selectedState = stateAndLga.keys.first.obs;
  RxString selectedLga = stateAndLga.values.first.first.obs;
  // RxString bankName = 'Select bank'.obs;
  // RxBool hasVehicle = false.obs;

  // STEP TWO VARIABLES
  RxString selectedBank = banks.first.obs;
  RxString selectedId = governmentIds.first.obs;
  RxString ownVehicle = yesVehicle.first.obs;
  RxString financialCapacity = finance.first.obs;
  RxString cacImageUrl = ''.obs;
  RxString profileImageUrl = ''.obs;
  RxString govermentImageUrl = ''.obs;
  RxString letterHeadUrl = ''.obs;

  Color checkStepBase(int step) {
    bool isDone = steps['step${step + 1}']!['isDone']! &&
        steps['step${step + 1}']!['isActive']!;
    if (isDone) return AppColor.primary;
    if (steps['step${step + 1}']!['isActive']!) return AppColor.primary;
    return AppColor.iconInactive;
  }

  Color checkDivider(int step) {
    bool isDone = steps['step${step + 1}']!['isDone']! &&
        steps['step${step + 1}']!['isActive']!;
    if (isDone) return AppColor.primary;
    return AppColor.iconInactive;
  }

  Color checkStepInnerBase(int step) {
    bool isDone = steps['step${step + 1}']!['isDone']! &&
        steps['step${step + 1}']!['isActive']!;
    if (isDone) return AppColor.primary;
    return AppColor.white;
  }

  Color checkSvgBase(int step) {
    bool isDone = steps['step${step + 1}']!['isDone']! &&
        steps['step${step + 1}']!['isActive']!;
    if (isDone) return AppColor.white;
    if (steps['step${step + 1}']!['isActive']!) return AppColor.primary;
    return AppColor.iconInactive;
  }

  Color checkTextColor(int step) {
    bool isDone = steps['step${step + 1}']!['isDone']! &&
        steps['step${step + 1}']!['isActive']!;
    if (isDone) return AppColor.primary;
    if (steps['step${step + 1}']!['isActive']!) return AppColor.primary;
    return AppColor.greyLigth;
  }

  goBack() {
    HC.hideKeyBoard();
    if (currentPage.value == 0) {
      // cancel timer if still running
      _timer?.cancel();
      //cancel ongoing request to the server
      MyRequestClass.cancelAllConnection();
      //delete all uploaded images
      Config.deleteAllLocalUnuseImage();
      log("Deleting uploaded images");
      if (Get.previousRoute != AppRoutes.name(RouteName.welcome)) {
        return Get.back();
      }
      return Get.offAllNamed(AppRoutes.name(RouteName.login));
    }
    //moving to the previous sceen
    pageController.animateToPage(currentPage.value - 1,
        duration: CW.onesSec, curve: Curves.easeIn);
    //setting the previous screen stepper is isActive to false
    steps['step${currentPage.value + 1}']!['isActive'] = false;
    //setting the previous screen stepper is isDone to false
    steps['step${currentPage.value}']!['isDone'] = false;
  }

  bool stepChecker(String step) {
    switch (step) {
      case 'step1':
        return steps[step]!['hasData'] = fullName!.text.trim().isNotEmpty &&
            companyName!.text.trim().isNotEmpty &&
            phoneNumber!.text.trim().length == 11 &&
            selectedState.value != stateAndLga.keys.first &&
            profileImageUrl.value.isNotEmpty;
      case 'step2':
        return steps[step]!['hasData'] = accountName!.text.trim().isNotEmpty &&
            accountNumber!.text.trim().length == 10 &&
            selectedBank.value != banks.first;
      case 'step3':
        return steps[step]!['hasData'] = fullAddress!.text.trim().isNotEmpty &&
            selectedId.value != governmentIds.first &&
            govermentImageUrl.value.isNotEmpty;
      //  && cacImageUrl.value.isNotEmpty &&
      // letterHeadUrl.value.isNotEmpty;
      case 'step4':
        hasValidEmail.value = HC.validateEmail(email!.text);
        return isValidCredentails.value = email!.text.trim().isNotEmpty &&
            password!.text.trim().isNotEmpty &&
            confirmPassword!.text.trim() == password!.text.trim();
      default:
        return false;
    }
  }

  validateOTP() {
    return hasInputCode.value = code!.text.length == 7;
  }

  next() {
    HC.hideKeyBoard();
    if (currentPage.value == 2) {
      return Get.toNamed(AppRoutes.name(RouteName.createAccount));
    }
    //setting the current screen stepper is done to false
    steps['step${currentPage.value + 1}']!['isDone'] = true;
    //moving to the next sceen
    pageController.nextPage(duration: CW.quarterSec, curve: Curves.easeIn);
    // setting the next screen stepper to active
    steps['step${currentPage.value + 2}']!['isActive'] = true;
  }

  submit() async {
    HC.hideKeyBoard();
    try {
      isLoading.value = true;
      if (confirmPassword!.text.trim() == password!.text.trim()) {
        log(phoneNumber2!.text.trim().isEmpty.toString() + "------- phone");
        CreateAccountModel data = CreateAccountModel(
            fullName: fullName!.text.trim(),
            phoneNumber: phoneNumber!.text.trim(),
            phoneNumber2: phoneNumber2!.text.trim().isEmpty
                ? "null"
                : phoneNumber2!.text.trim(),
            accountName: accountName!.text.trim(),
            accountNumber: accountNumber!.text.trim(),
            address: fullAddress!.text.trim(),
            state: selectedState.value,
            lga: selectedLga.value,
            bankName: selectedBank.value,
            govId: selectedId.value,
            ownVehicle: ownVehicle.value,
            financialCapacity: financialCapacity.value,
            cacUrl: cacImageUrl.value.isEmpty ? "null" : cacImageUrl.value,
            governmentIdImageUrl: govermentImageUrl.value.isEmpty
                ? "null"
                : govermentImageUrl.value,
            companyName: companyName!.text.trim(),
            profileImageUrl: profileImageUrl.value,
            letterHeadImageUrl:
                letterHeadUrl.value.isEmpty ? "null" : letterHeadUrl.value,
            code: code!.text.trim().replaceAll('-', ''),
            email: email!.text.trim(),
            password: password!.text.trim());
        log(data.toJson().toString());
        // isLoading.value = false;
        // return;
        RequestResponsModel response = await MyRequestClass.krequest(
            endPoint: EndPoint.register,
            body: data.toJson(),
            method: Methods.put);
        if (response.success) {
          await Config.clearImageUrls();
          final data = await AppStorage.readData(
              storageName: StorageNames.config.name,
              key: ConfigStorageKey.uploadUrls.name);
          log(data.toString());
          HC.snack(response.message, success: response.success);
          isLoading.value = false;
          return Get.offAllNamed(AppRoutes.name(RouteName.login));
        }
        HC.snack(response.message, success: response.success);

        return;
      }
      isLoading.value = false;
      return HC.snack("Password didn't match", success: false);
    } catch (e) {
      isLoading.value = false;
      return HC.snack("$e", success: false);
    }
  }

  @override
  void onClose() {
    Config.deleteAllLocalUnuseImage();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    emailFocus.dispose();
    // disposing all text editing controllers
    email?.dispose();
    password?.dispose();
    confirmPassword?.dispose();
    fullName?.dispose();
    companyName?.dispose();
    phoneNumber?.dispose();
    phoneNumber2?.dispose();
    accountName?.dispose();
    accountNumber?.dispose();
    fullAddress?.dispose();
    // ignore: invalid_use_of_protected_member
    createAccountFormKey.currentState?.dispose();
    // ignore: invalid_use_of_protected_member
    stepFormKey.currentState?.dispose();
    // ignore: invalid_use_of_protected_member
    step2FormKey.currentState?.dispose();
    // ignore: invalid_use_of_protected_member
    step3FormKey.currentState?.dispose();
    super.onClose();
  }

  dynamic checkPasswordStrenght() {
    return HC.validatePasswordStrength(password!.text.trim())['message'];
  }

  uploadImage({
    required UploadType type,
    required IdType? idType,
    required controller,
  }) async {
    //type is the folder name where the file is going to be store in the database
    //idType is the type of image they re uploading to know which to check for.
    File? pickedImage = await HC.pickImage(ImageSource.gallery);
    log(pickedImage.toString());
    if (pickedImage == null) return null;
    int imageSize = await pickedImage.stat().then((value) => value.size);
    if (imageSize > 5000000) return HC.snack("File too big to upload");
    String mimitype =
        pickedImage.path.split('/').last.split('.').last.toLowerCase();
    log(mimitype);
    switch (idType) {
      case IdType.government:
        if (selectedId.value == governmentIds.first) {
          return HC.snack("Select a approved id type");
        }
        isUploadingGovImage(true);
        isUploadingProfileImage(true);
        log('starting upload $pickedImage');
        RequestResponsModel response = await MyRequestClass.uploadImage(
            filePath: pickedImage,
            imageUploadType: type,
            fileType: mimitype == 'pdf' ? ImageType.PDF : ImageType.IMAGE,
            controller: controller);
        if (response.success) govermentImageUrl.value = response.data['others'];
        log('done upload');
        stepChecker('step3');
        isUploadingGovImage(false);
        break;
      case IdType.cac:
        isUploadingCacImage(true);
        RequestResponsModel response = await MyRequestClass.uploadImage(
            filePath: pickedImage,
            imageUploadType: type,
            fileType: mimitype == 'pdf' ? ImageType.PDF : ImageType.IMAGE,
            controller: controller);
        cacImageUrl.value = response.data['others'];
        stepChecker('step3');
        isUploadingCacImage(false);
        break;
      case IdType.letterHeaded:
        isUploadingLetterImage(true);
        RequestResponsModel response = await MyRequestClass.uploadImage(
            filePath: pickedImage,
            imageUploadType: type,
            fileType: mimitype == 'pdf' ? ImageType.PDF : ImageType.IMAGE,
            controller: controller);
        letterHeadUrl.value = response.data['others'];
        stepChecker('step3');
        isUploadingLetterImage(false);
        break;
      case IdType.profleImage:
        isUploadingProfileImage(true);
        RequestResponsModel response = await MyRequestClass.uploadImage(
            filePath: pickedImage,
            imageUploadType: type,
            fileType: mimitype == 'pdf' ? ImageType.PDF : ImageType.IMAGE,
            controller: controller);
        profileImageUrl.value = response.data['others'];
        stepChecker('step1');
        isUploadingProfileImage(false);
        break;
      default:
        break;
    }
  }

  void requestEmailVerificationCode() async {
    HC.hideKeyBoard();
    isLoading.value = true;
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.generateEmailToken,
        body: {"email": email!.text},
        method: Methods.post);
    if (response.success) {
      hasRequestVerifyEmail(true);
      canSendEmailVerificationRequest(false);
      startTimer();
      isLoading.value = false;
      return HC.snack(response.message, success: true);
    }
    isLoading.value = false;
    HC.snack(response.message);
  }

  deleteUploadedImage(String downloadUrl, IdType type) {
    MyRequestClass.deleteRequest(
        url: downloadUrl, endPoint: EndPoint.deleteImage);
    switch (type) {
      case IdType.profleImage:
        profileImageUrl('');
        break;
      case IdType.cac:
        cacImageUrl('');
        break;
      case IdType.government:
        govermentImageUrl('');
        break;
      case IdType.letterHeaded:
        letterHeadUrl('');
        break;
      default:
        return false;
    }
  }

  editEmail() {
    hasRequestVerifyEmail.value = false;
    hasVerifiedEmail.value = false;
    _timer!.cancel();
  }

  verifyEmail() async {
    HC.hideKeyBoard();
    isLoading.value = true;
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.validateEmailCode,
        body: {"email": email!.text, "code": code!.text.replaceAll('-', '')},
        method: Methods.patch);
    if (response.success) {
      hasVerifiedEmail.value = true;
      canSendEmailVerificationRequest.value = true;
      isLoading.value = false;
      return HC.snack(response.message, success: response.success);
    }
    isLoading.value = false;
    return HC.snack(response.message, success: response.success);
  }
}
