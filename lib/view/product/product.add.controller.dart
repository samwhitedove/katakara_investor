import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/helper/helper.settings.dart';
import 'package:katakara_investor/models/product/model.select.image.dart';
import 'package:katakara_investor/models/product/model.upload.product.dart';
import 'package:katakara_investor/models/product/models.fetch.portfolio.response.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/services.portfolio.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/view.dart';

class AddProductController extends GetxController {
  List<(String, int)> uploadedImage = <(String, int)>[];
  List<SelectImageModel> processImage = <SelectImageModel>[];
  // Seller image data
  List<(String, int)> uploadedSellerImage = <(String, int)>[];
  List<SelectImageModel> processSellerImage = <SelectImageModel>[];
  // get product data if to edit
  final Datum? productInfo = Get.arguments;
  bool hasUpdate = false;
  bool hasData = false;

  setViewForUpdateproduct() async {
    // fetch view from local save data
    final localData =
        await AppSettings.getAppState(LocalStateName.addPortfolio);

    Datum? getData;
    if (productInfo != null) {
      getData = productInfo;
    } else {
      if (localData != null) getData = Datum.fromJson(localData);
    }

    if (getData == null) return;

    for (var i = 0; i < getData.productImage!.length; i++) {
      uploadedImage.add((getData.productImage![i], i));
      processImage.add(SelectImageModel(
          id: i,
          isLoading: false,
          isUploaded: true,
          path: getData.productImage![i]));
    }
    for (var i = 0; i < getData.sellerImage!.length; i++) {
      uploadedSellerImage.add((getData.sellerImage![i], i));
      processSellerImage.add(SelectImageModel(
          id: i,
          isLoading: false,
          isUploaded: true,
          path: getData.sellerImage![i]));
    }

    category.value = getData.category!;
    productName!.text = getData.productName!;
    description!.text = getData.description!;
    amountBuy!.text = getData.amountBuy!;
    amountSell!.text = getData.amount!;
    selectedState.value = getData.state!;
    selectedLga.value = getData.lga!;
    onChange(init: true);
    update();
  }

  TextEditingController? productName;
  TextEditingController? description;
  TextEditingController? amountSell;
  TextEditingController? amountBuy;
  RxBool canUpload = false.obs;
  RxBool isUploading = false.obs;

  RxString selectedState = stateAndLga.keys.first.obs;
  RxString selectedLga = stateAndLga.values.first.first.obs;
  RxString category = productCategory.first.obs;
  final portfolioService = Get.find<PortfolioService>();
  final portfolioController = Get.find<PortfolioController>();

  @override
  onInit() {
    super.onInit();
    productName = TextEditingController();
    amountSell = TextEditingController();
    amountBuy = TextEditingController();
    description = TextEditingController();
    setViewForUpdateproduct();
  }

  onChange({bool init = false}) {
    if (productInfo != null && init == false) hasUpdate = true;
    canUpload.value = productName!.text.trim().isNotEmpty &&
        amountBuy!.text.trim().isNotEmpty &&
        amountSell!.text.trim().isNotEmpty &&
        description!.text.trim().isNotEmpty &&
        selectedState.value != stateAndLga.keys.first &&
        selectedLga.value != stateAndLga.values.first.first &&
        category.value != productCategory.first &&
        uploadedImage.isNotEmpty;
    hasData = productName!.text.trim().isNotEmpty ||
        amountBuy!.text.trim().isNotEmpty ||
        amountSell!.text.trim().isNotEmpty ||
        description!.text.trim().isNotEmpty ||
        selectedState.value != stateAndLga.keys.first ||
        selectedLga.value != stateAndLga.values.first.first ||
        category.value != productCategory.first ||
        uploadedImage.isNotEmpty;
  }

  setState(String text) {
    // if (productInfo != null) hasUpdate = true;
    selectedLga.value = text;
    onChange();
    update();
  }

  setLga(String text) {
    // if (productInfo != null) hasUpdate = true;
    selectedState.value = text;
    selectedLga.value = stateAndLga[text]!.first;
    onChange();
    update();
  }

  setCategory(String text) {
    // if (productInfo != null) hasUpdate = true;
    category.value = text;
    onChange();
    update();
  }

  @override
  onClose() {
    productName?.dispose();
    amountSell?.dispose();
    amountBuy?.dispose();
    description?.dispose();
    super.onClose();
  }

  List<List<String>> _loopThroughImages() {
    List<String> images = <String>[], sellerImages = <String>[];
    // loop through uploaded image and add to images for upload
    for (var e in uploadedImage) {
      images.add(e.$1);
    }

    for (var e in uploadedSellerImage) {
      sellerImages.add(e.$1);
    }

    return [images, sellerImages];
  }

  void _removeImageFromlocal(List<List<String>> image) {
    for (var e in image[0]) {
      AppSettings.removeUploadeImageUrlFromStorage(value: e);
    }

    for (var e in image[1]) {
      AppSettings.removeUploadeImageUrlFromStorage(value: e);
    }
  }

  uploadProduct() async {
    bool isUpdate = productInfo != null;
    //remove all empty data
    uploadedSellerImage.removeWhere((item) => item.$1.isEmpty);
    if (!canUpload.value) {
      HC.snack("Complete the above fields");
    }
    isUploading.value = true;
    update();

    final images = _loopThroughImages();
    final product = UploadProductModel(
      amount: amountSell!.text,
      description: description!.text,
      category: category.value,
      amountBuy: amountBuy!.text,
      lga: selectedLga.value,
      state: selectedState.value,
      productImage: images[0],
      sellerImage: images[1],
      productName: productName!.text,
    );
    final RequestResponseModel response = isUpdate
        ? await portfolioService.updateProductPortfolio(
            product.toJson()..addAll({"sku": productInfo!.sku!}))
        : await portfolioService.addProductToPortfolio(product);
    isUploading.value = false;

    update();
    if (response.success) {
      // if (productInfo != null) hasUpdate = true;
      // loop through images and delete them from local storage.
      _removeImageFromlocal(images);
      HC.snack(response.message, success: response.success);
      portfolioController.fetchPortfolio();
      Get.close(productInfo != null ? 2 : 1);
      return;
    }

    HC.snack(response.message, success: response.success);
    isUploading.value = false;
    update();
  }

  _uploadNewImage(File imagePath, bool isSellerImage) {
    final isChooseFile = isSellerImage ? processSellerImage : processImage;
    isChooseFile.insert(
        0,
        SelectImageModel(
          isLoading: true,
          isUploaded: false,
          path: imagePath.path,
          id: isChooseFile.length,
        ));
    //upload to online
    _uploadImage(imagePath.path, isChooseFile.length - 1, isSellerImage);
    update();
  }

  void _uploadImage(String imagePath, index, isSeller) async {
    try {
      // chose which list to work on depend if its a seller image or a product image
      final isChooseProcess = isSeller ? processSellerImage : processImage;
      final isChooseUploaded = isSeller ? uploadedSellerImage : uploadedImage;
      // get the current image position from the selected process for upload
      final SelectImageModel data =
          isChooseProcess.where((item) => item.id == index).first;
      final RequestResponseModel response = await portfolioService
          .uploadProductImage(pickedImage: File(imagePath));
      data.isLoading = false;
      update();
      if (response.success) {
        // if (productInfo != null) hasUpdate = true;
        data.isUploaded = true;
        // add the uploaded image url to selected list uploaded image
        isChooseUploaded.add((response.data, index));
        onChange();
        update();
        return;
      }
      // if uploading of image in unsucceful remove it from the process image list
      isChooseProcess.removeWhere((element) => element.id == index);
      HC.snack(response.message, success: response.success);
    } catch (e) {
      log(e.toString());
    }
  }

  deleteUploadedImage(index, isSeller) async {
    // chose which list to work on depend if its a seller image or a product image
    final isChooseProcess = isSeller ? processSellerImage : processImage;
    final isChooseUploaded = isSeller ? uploadedSellerImage : uploadedImage;
    // get the current image position from the selected process for upload
    final image = isChooseProcess.where((item) => item.id == index).first;
    final uploadsImg = isChooseUploaded.where((item) => item.$2 == index).first;
    image.isUploaded = false;
    image.isLoading = true;
    update();
    // send a delete request
    final RequestResponseModel response =
        await portfolioService.deleteImage(pickedImage: uploadsImg.$1);
    if (response.success) {
      // if (productInfo != null) hasUpdate = true;

      // remove the item from uploaded list of image.
      isChooseProcess.removeWhere((item) => item.id == index);
      isChooseUploaded.removeWhere((item) => item.$2 == index);
      onChange();
      update();
      return;
    }
    image.isUploaded = true;
    image.isLoading = false;
    update();
    HC.snack(response.message, success: response.success);
  }

  handleImage(ImageSource source, bool isSellerImage) async {
    try {
      Get.back();
      final Map<String, dynamic> selected = await HC.pickAndCheckImage(source);
      if (selected['hasImage']) {
        _uploadNewImage(selected['image'], isSellerImage);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  saveAddProductToLocal() {
    final images = _loopThroughImages();
    final data = UploadProductModel(
      amount: amountSell!.text,
      description: description!.text,
      category: category.value,
      amountBuy: amountBuy!.text,
      lga: selectedLga.value,
      state: selectedState.value,
      productImage: images[0],
      sellerImage: images[1],
      productName: productName!.text,
    );

    AppSettings.saveAppState(
      data.toJson(),
      LocalStateName.addPortfolio,
    );
  }
}
