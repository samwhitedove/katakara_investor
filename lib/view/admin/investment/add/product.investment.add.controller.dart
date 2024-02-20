import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/helper/helper.settings.dart';
import 'package:katakara_investor/models/product/model.category.dart';
import 'package:katakara_investor/models/product/model.investment.dart';
import 'package:katakara_investor/models/product/model.select.image.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.admin.dart';
import 'package:katakara_investor/services/services.portfolio.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/investment/active/admin.investment.controller.dart';
import 'package:katakara_investor/view/admin/investment/active/model.response.dart';

class AddInvestmentProductController extends GetxController {
  List<(String, int)> uploadedImage = <(String, int)>[];
  List<SelectImageModel> processImage = <SelectImageModel>[];
  // get product data if to edit
  final _ = Get.put(UploadedProductController());
  final investmentViewController = Get.find<UploadedProductController>();
  final InvestmentDatum? productInfo = Get.arguments;
  final List<String> imageToDelete = <String>[];

  bool hasUpdate = false;
  bool hasData = false;

  setViewForUpdateproduct() async {
    // fetch view from local save data
    if (productInfo == null) return;
    final productImage = productInfo!.productImage!.split(',').toList()
      ..removeWhere((element) => element == '');
    for (var i = 0; i < productImage.length; i++) {
      uploadedImage.add((productImage[i], i));
      processImage.add(SelectImageModel(
          id: i, isLoading: false, isUploaded: true, path: productImage[i]));
    }

    category.value = productInfo!.category!;
    productName!.text = productInfo!.productName!;
    description!.text = productInfo!.description!;
    sellerName!.text = productInfo!.sellerName!;
    amountSell!.text = productInfo!.amount!;
    sellerAddress!.text = productInfo!.sellerAddress!;
    selectedState.value = productInfo!.state!;
    selectedLga.value = productInfo!.lga!;
    onChange(init: true);
    update();
  }

  cancelUpdate() async {
    for (dynamic item in productInfo!.productImage!.split(',')) {
      uploadedImage.removeWhere((element) => element.$1 == item);
    }

    Get.close(2);
    for (var element in uploadedImage) {
      await portfolioService.deleteImage(pickedImage: element.$1);
    }
  }

  TextEditingController? productName;
  TextEditingController? description;
  TextEditingController? amountSell;
  TextEditingController? sellerName;
  TextEditingController? sellerAddress;
  RxBool canUpload = false.obs;
  RxBool isUploading = false.obs;
  RxBool isFetchingCategory = false.obs;

  RxString selectedState = stateAndLga.keys.first.obs;
  RxString selectedLga = stateAndLga.values.first.first.obs;
  RxString category = "".obs; // "productCategory.first.obs";
  final portfolioService = Get.find<PortfolioService>();
  final adminService = Get.find<AdminService>();
  // final portfolioController = Get.find<PortfolioController>();
  List<String> categories = <String>[];

  @override
  onInit() {
    super.onInit();
    fetchProductCategory();
    productName = TextEditingController();
    amountSell = TextEditingController();
    sellerName = TextEditingController();
    description = TextEditingController();
    sellerAddress = TextEditingController();
    setViewForUpdateproduct();
  }

  fetchProductCategory() async {
    isFetchingCategory.value = true;
    final RequestResponseModel response =
        await portfolioService.fetchProductCategory();
    if (response.success) {
      List data = response.data ?? [];
      if (data.isNotEmpty) {
        for (var element in data) {
          categories.add(Category.fromJson(element).category.toString());
        }
        // set category from the passed arguements
        category.value = productInfo != null
            ? productInfo!.category!.toUpperCase()
            : categories.first;
        log(categories.toString());
      }
      isFetchingCategory.value = false;
    }
  }

  onChange({bool init = false}) {
    if (productInfo != null && init == false) hasUpdate = true;
    canUpload.value = productName!.text.trim().isNotEmpty &&
        sellerName!.text.trim().isNotEmpty &&
        amountSell!.text.trim().isNotEmpty &&
        description!.text.trim().isNotEmpty &&
        sellerAddress!.text.trim().isNotEmpty &&
        selectedState.value != stateAndLga.keys.first &&
        selectedLga.value != stateAndLga.values.first.first &&
        category.value != productCategory.first &&
        uploadedImage.isNotEmpty;
    hasData = productName!.text.trim().isNotEmpty ||
        sellerName!.text.trim().isNotEmpty ||
        amountSell!.text.trim().isNotEmpty ||
        sellerAddress!.text.trim().isNotEmpty ||
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
    sellerAddress?.dispose();
    sellerName?.dispose();
    description?.dispose();
    super.onClose();
  }

  List<List<String>> _loopThroughImages() {
    List<String> images = <String>[], sellerImages = <String>[];
    // loop through uploaded image and add to images for upload
    for (var e in uploadedImage) {
      images.add(e.$1);
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
    if (!canUpload.value) {
      HC.snack("Complete the above fields");
    }
    isUploading.value = true;
    update();

    final images = _loopThroughImages();
    final product = InvestmentDataModel(
      amount: amountSell!.text,
      description: description!.text,
      category: category.value,
      sellerAddress: sellerAddress!.text,
      lga: selectedLga.value,
      state: selectedState.value,
      productImage: images[0],
      sellerName: sellerName!.text,
      productName: productName!.text,
    );
    final RequestResponseModel response = isUpdate
        ? await adminService.updateInvestment(
            product.toJson()..addAll({"sku": productInfo!.sku!}))
        : await adminService.addInvestment(product);
    isUploading.value = false;
    update();
    if (response.success) {
      // loop through images and delete them from local storage.
      _removeImageFromlocal(images);
      HC.snack(response.message, success: response.success);
      Get.close(isUpdate ? 2 : 1);
      if (isUpdate) await investmentViewController.fetchInvestment();
      // check if any image was remove during update to properly remove from db
      if (imageToDelete.isNotEmpty) {
        for (var k in imageToDelete) {
          if (k != "") await portfolioService.deleteImage(pickedImage: k);
        }
      }
      return;
    }

    HC.snack(response.message, success: response.success);
    isUploading.value = false;
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
        onChange();
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
    // chose which list to work on depend if its a seller image or a product image
    final image = processImage.where((item) => item.id == index).first;
    final uploadsImg = uploadedImage.where((item) => item.$2 == index).first;
    // send a delete request
    if (productInfo != null) {
      imageToDelete.add(image.path ?? "");
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
      onChange();
      update();
      return;
    }
    image.isUploaded = true;
    image.isLoading = false;
    update();
    HC.snack(response.message, success: response.success);
  }

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

  saveAddProductToLocal() {
    final images = _loopThroughImages();
    final data = InvestmentDataModel(
      amount: amountSell!.text,
      description: description!.text,
      category: category.value,
      sellerName: sellerName!.text,
      lga: selectedLga.value,
      state: selectedState.value,
      productImage: images[0],
      sellerAddress: sellerAddress!.text,
      productName: productName!.text,
    );

    AppSettings.saveAppState(
      data.toJson(),
      LocalStateName.addInvestment,
    );
  }
}
