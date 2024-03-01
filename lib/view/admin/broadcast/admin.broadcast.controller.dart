import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katakara_investor/helper/helper.function.dart';
import 'package:katakara_investor/models/product/model.select.image.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.admin.dart';
import 'package:katakara_investor/services/services.portfolio.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/investment/active/admin.investment.controller.dart';
import 'package:katakara_investor/view/admin/investment/active/model.response.dart';

class BroadcastController extends GetxController {
  List<(String, int)> uploadedImage = <(String, int)>[];
  List<SelectImageModel> processImage = <SelectImageModel>[];
  final InvestmentDatum? productInfo = Get.arguments;
  final List<String> imageToDelete = <String>[];

  final portfolioService = Get.find<PortfolioService>();
  final adminService = Get.find<AdminService>();
  final _ = Get.put(AdminInvestmentActiveController());
  final investmentViewController = Get.find<AdminInvestmentActiveController>();
  TextEditingController title = TextEditingController();
  TextEditingController message = TextEditingController();

  List<String> broadcastType = ["General", "Location"];
  List<String> states = stateAndLga.keys.toList();
  RxBool isBroadcasting = false.obs;

  RxString selectedBroadCast = "General".obs;
  RxString selectedState = "-- Select State --".obs;

  handleImage(ImageSource source) async {
    try {
      Get.back();
      final Map<String, dynamic> selected = await HC.pickAndCheckImage(source);
      if (selected['hasImage']) {
        _uploadNewImage(selected['image']);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  RxBool canSend = false.obs;
  confirmCanSend() {
    final lc = selectedBroadCast.value == "Location";
    final state = selectedState.value != stateAndLga.keys.toList()[0];
    if (lc) {
      return canSend.value =
          lc && state && title.text.isNotEmpty && message.text.isNotEmpty;
    }
    canSend.value = title.text.isNotEmpty && message.text.isNotEmpty;
  }

  setCategory(String text) {
    selectedBroadCast.value = text;
    confirmCanSend();
    update();
  }

  setState(String text) {
    selectedState.value = text;
    confirmCanSend();
    update();
  }

  _uploadNewImage(File imagePath) {
    processImage.insert(
        0,
        SelectImageModel(
          isLoading: true,
          isUploaded: false,
          path: imagePath.path,
          id: processImage.length,
        ));
    //upload to online
    _uploadImage(imagePath.path, processImage.length - 1);
    update();
  }

  void _uploadImage(String imagePath, index) async {
    try {
      // chose which list to work on depend if its a seller image or a product image
      final SelectImageModel data =
          processImage.where((item) => item.id == index).first;
      final RequestResponseModel response = await portfolioService
          .uploadProductImage(pickedImage: File(imagePath));
      data.isLoading = false;
      update();
      if (response.success) {
        // if (productInfo != null) hasUpdate = true;
        data.isUploaded = true;
        // add the uploaded image url to selected list uploaded image
        uploadedImage.add((response.data, index));
        update();
        return;
      }
      // if uploading of image in unsucceful remove it from the process image list
      processImage.removeWhere((element) => element.id == index);
      HC.snack(response.message, success: response.success);
    } catch (e) {
      log(e.toString());
    }
  }

  deleteUploadedImage(index, isSeller) async {
    log("startign remove");
    // chose which list to work on depend if its a seller image or a product image
    final image = processImage.where((item) => item.id == index).first;
    final uploadsImg = uploadedImage.where((item) => item.$2 == index).first;
    // send a delete request
    if (productInfo != null) {
      imageToDelete.add(image.path ?? "");
      processImage.removeWhere((item) => item.path == image.path);
      uploadedImage.removeWhere((item) => item.$2 == uploadsImg.$2);
      update();
      return;
    }
    image.isUploaded = false;
    image.isLoading = true;
    update();
    final RequestResponseModel response =
        await portfolioService.deleteImage(pickedImage: uploadsImg.$1);
    if (response.success) {
      // remove the item from uploaded list of image.
      processImage.removeWhere((item) => item.id == index);
      uploadedImage.removeWhere((item) => item.$2 == index);
      update();
      return;
    }
    image.isUploaded = true;
    image.isLoading = false;
    update();
    HC.snack(response.message, success: response.success);
  }

  sendBroadcast() async {
    HC.hideKeyBoard();
    isBroadcasting.value = false;
    final RequestResponseModel response = await adminService.sendBroadcast({
      "title": title.text,
      "message": message.text,
      "type": selectedBroadCast.value,
      if (selectedBroadCast.value == "Location") "state": selectedState.value,
      if (uploadedImage.isNotEmpty) "image": uploadedImage[0].$1,
    });

    isBroadcasting.value = false;
    update();
    HC.snack(response.message, success: response.success);
    if (response.success) Get.back();
  }
}
