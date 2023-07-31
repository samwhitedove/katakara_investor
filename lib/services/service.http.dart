import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:katakara_investor/helper/helper.local.storage.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/values/values.dart';

import '../models/services/model.service.response.dart';

class MyRequestClass {
  static String _baseUrl = "http://3.88.230.155:4000/api/v1";
  static CancelToken? cancelToken;
  static Dio? _dio;

  static BaseOptions _dioOption = BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  );

  static cancelAllConnection() {
    cancelToken?.cancel();
  }

  static Future krequest({
    required String endPoint,
    required Methods method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    log(endPoint);
    try {
      final headers = {
        "Content-Type": "application/json",
        'authorization': "Bearer ${userData.token}"
      };

      _dio = Dio(_dioOption..headers = headers);
      final response;
      switch (method) {
        case Methods.post:
          response = await _dio?.post(endPoint, data: body);
          break;
        case Methods.get:
          response = await _dio?.get(endPoint, queryParameters: query);
          break;
        case Methods.put:
          response = await _dio?.put(endPoint, data: body);
          break;
        case Methods.delete:
          response = await _dio?.delete(endPoint, data: body);
          break;
        case Methods.patch:
          response = await _dio?.patch(endPoint, data: body);
          break;
        default:
          throw 'Invalid request method';
      }

      RequestResponsModel resp = RequestResponsModel.fromJson(response!.data);
      log(resp.toJson().toString());
      if (resp.statusCode == 500) {
        return RequestResponsModel(
            message: "Cannot process data at the moment");
      }
      // log(resp.toJson().toString());

      return resp;
    } catch (e) {
      log('$e--------- 2 2 2 2');
      if (e is DioException) {
        return handleDioError(e);
      }
      return RequestResponsModel(message: e.toString());
    }
  }

  static Future<RequestResponsModel> uploadImageWithToken({
    required File filePath,
    UploadType? imageUploadType,
    required dynamic controller,
    String? id,
    required String endpoint,
    ImageType fileType = ImageType.IMAGE,
  }) async {
    final headers = {
      "Content-Type": "multipart/form-data",
      'authorization': "Bearer ${userData.token}"
    };
    _dio = Dio(_dioOption..headers = headers);
    final image = await MultipartFile.fromFile(
      filePath.path,
      contentType: fileType == ImageType.IMAGE
          ? MediaType('image', 'jpeg')
          : MediaType('application', 'pdf'),
    );

    try {
      var formData = FormData();
      if (id != null) formData.fields.add(MapEntry('id', id));
      if (imageUploadType != null)
        formData.fields.add(MapEntry('path', imageUploadType.name));
      formData.files.add(MapEntry('image', image));

      final response = await _dio?.patch(
        endpoint,
        data: formData,
        onSendProgress: (count, total) {
          log('$count --- $total');
          controller.uploadProgress(
              (count.toDouble() / 1000) / (total.toDouble() / 1000) - .23);
        },
      );
      controller.uploadProgress(0.0);

      RequestResponsModel resp = RequestResponsModel.fromJson(response?.data);

      log(resp.toJson().toString());
      if (resp.statusCode == 200) {
        final storageData = await AppStorage.readData(
            storageName: StorageNames.uploads.name,
            key: ConfigStorageKey.uploadUrls.name);
        AppStorage.saveData(
            storageName: StorageNames.uploads.name,
            key: ConfigStorageKey.uploadUrls.name,
            value: [...storageData]..add(resp.data['others']));
        return resp;
      }

      return resp;
    } catch (e) {
      log(e.toString());
      log('$e--------- 2 2 2 2');
      if (e is DioException) {
        return handleDioError(e);
      }
      return RequestResponsModel(message: e.toString(), success: false);
    }
  }

  static Future<RequestResponsModel> uploadImage({
    required File filePath,
    required UploadType imageUploadType,
    required dynamic controller,
    ImageType fileType = ImageType.IMAGE,
  }) async {
    final headers = {"Content-Type": "multipart/form-data"};
    _dioOption..receiveTimeout = Duration(seconds: 300);
    _dio = Dio(_dioOption..headers = headers);
    final image = await MultipartFile.fromFile(
      filePath.path,
      contentType: fileType == ImageType.IMAGE
          ? MediaType('image', 'jpeg')
          : MediaType('application', 'pdf'),
    );

    try {
      var formData = FormData();
      formData.fields.add(MapEntry('path', imageUploadType.name));
      formData.files.add(MapEntry('image', image));

      final response = await _dio?.put(
        EndPoint.uploadImage,
        data: formData,
        onSendProgress: (count, total) {
          log('$count --- $total');
          controller.uploadProgress(
              (count.toDouble() / 1000) / (total.toDouble() / 1000) - .23);
        },
      );
      controller.uploadProgress(0.0);

      RequestResponsModel resp = RequestResponsModel.fromJson(response?.data);

      log(resp.toJson().toString());
      if (resp.statusCode == 200) {
        final storageData = await AppStorage.readData(
            storageName: StorageNames.uploads.name,
            key: ConfigStorageKey.uploadUrls.name);
        AppStorage.saveData(
            storageName: StorageNames.uploads.name,
            key: ConfigStorageKey.uploadUrls.name,
            value: [...storageData]..add(resp.data['others']));
        return resp;
      }

      return resp;
    } catch (e) {
      log(e.toString());
      log('$e--------- 2 2 2 2');
      if (e is DioException) {
        return handleDioError(e);
      }
      return RequestResponsModel(message: e.toString(), success: false);
    }
  }

  static RequestResponsModel handleDioError(DioException error) {
    log('--------------- its dio error ${error.type}');
    if (error.type == DioExceptionType.connectionTimeout) {
      // return RequestResponsModel(message: error.message, success: false);
      log('Send timeout error: ${error.message}');
      return RequestResponsModel(
          message: "Server connection timeout, please try again");
    } else if (error.type == DioExceptionType.sendTimeout) {
      // Handle send timeout error
      log('Send timeout error: ${error.message}');
      return RequestResponsModel(
          message: "Server not responding, please try again");
    } else if (error.type == DioExceptionType.receiveTimeout) {
      // Handle receive timeout error
      log('Receive timeout error: ${error.message}');
      return RequestResponsModel(message: "Server timeout, please try again");
    } else if (error.type == DioExceptionType.unknown) {
      log('Response unknown error: ${error.message}');
      log('Response unknown status code: ${error.response?.statusCode}');
      log('Response unknown data: ${error.response?.data}');
      return RequestResponsModel(
          message: "Unknown Server error, please try again");
    } else if (error.type == DioExceptionType.badResponse) {
      // Handle response error
      log('Response bad request error: ${error.message}');
      log('Response bad request status code: ${error.response?.statusCode}');
      log('Response bad request data: ${error.response?.data}');
      return RequestResponsModel(
        message: error.response?.data?['message'],
        statusCode: error.response?.data?['statusCode'],
        success: error.response?.data?['success'] ?? false,
      );
    } else if (error.type == DioExceptionType.cancel) {
      // Handle request cancellation
      log('Request cancelled: ${error.message}');
      return RequestResponsModel(message: error.message);
    } else {
      // Handle other Dio errors
      log('Other Dio error: ${error.message}');
      return RequestResponsModel(message: error.message);
    }
  }

  static void deleteRequest(
      {required String url, required String endPoint}) async {
    final headers = {"Content-Type": "application/json"};
    _dioOption..headers = headers;
    _dio = Dio(_dioOption);
    Map<String, String> body = {'downloadUrl': url};
    await _dio?.delete(endPoint, data: body);
  }
}

enum UploadType { Profile, Document, Product, Portfolio, Signature }

enum ImageType { PDF, IMAGE }
