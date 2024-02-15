import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:katakara_investor/models/product/model.upload.product.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class PortfolioService extends GetxController {
  Future<RequestResponseModel> addProductToPortfolio(
      UploadProductModel product) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.addPortfolio,
        method: Methods.post,
        body: product.toJson());
    log('${response.data} -----------save product');
    return response;
  }

  Future<RequestResponseModel> updateProductPortfolio(
      Map<String, dynamic> product) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.updatePortfolio,
        method: Methods.patch,
        body: product);
    log('${response.data} -----------update product');
    return response;
  }

  Future<RequestResponseModel> uploadProductImage(
      {required File pickedImage}) async {
    RequestResponseModel response = await MyRequestClass.uploadImage(
        filePath: pickedImage, fileType: ImageType.IMAGE);
    return response;
  }

  Future<RequestResponseModel> fetchPortfolio(
      {Map<String, dynamic> query = const {}}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchPortfolio, method: Methods.get, query: query);
    return response;
  }

  Future<RequestResponseModel> fetchProductCategory() async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchCategory, method: Methods.get);
    return response;
  }

  Future<RequestResponseModel> deleteProduct(String sku) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.deletePortfolio(sku), method: Methods.get);
    return response;
  }

  Future<RequestResponseModel> deleteImage(
      {required String pickedImage}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.deleteImage,
        method: Methods.delete,
        body: {
          'url': pickedImage,
        });
    return response;
  }
}
