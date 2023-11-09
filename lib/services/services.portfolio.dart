import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:katakara_investor/models/product/model.upload.product.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class PortfolioService extends GetxController {
  Future<RequestResponsModel> addProductToPortfolio(
      UploadProductModel product) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.addPortfolio,
        method: Methods.post,
        body: product.toJson());
    log('${response.data} -----------save product');
    return response;
  }

  Future<RequestResponsModel> updateProductPortfolio(
      Map<String, dynamic> product) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.updatePortfolio,
        method: Methods.patch,
        body: product);
    log('${response.data} -----------update product');
    return response;
  }

  Future<RequestResponsModel> uploadProductImage(
      {required File pickedImage}) async {
    RequestResponsModel response = await MyRequestClass.uploadImage(
        filePath: pickedImage, fileType: ImageType.IMAGE);
    return response;
  }

  Future<RequestResponsModel> fetchPortfolio(
      {Map<String, dynamic> query = const {}}) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchPortfolio, method: Methods.get, query: query);
    return response;
  }

  Future<RequestResponsModel> deleteProduct(String sku) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.deletePortfolio(sku), method: Methods.get);
    return response;
  }

  Future<RequestResponsModel> deleteImage({required String pickedImage}) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.deleteImage,
        method: Methods.delete,
        body: {
          'url': pickedImage,
        });
    return response;
  }
}
