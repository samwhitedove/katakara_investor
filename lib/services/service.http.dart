import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:http_parser/http_parser.dart';
import 'package:katakara_investor/helper/helper.settings.dart';
import 'package:katakara_investor/services/services.auth.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/view.dart';

import '../models/services/model.service.response.dart';

class MyRequestClass {
  static const String _baseUrl = "https://investor.mykatakara.com/api/v1";
  static CancelToken? cancelToken;
  static Dio? _dio;

  static final BaseOptions _dioOption = BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  static bool hasTryRefresh = false;

  static cancelAllConnection() {
    cancelToken?.cancel();
  }

  static InterceptorsWrapper _interceptor(Map<String, dynamic> data) {
    log(data.toString());
    return InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        log("HEADER ::- ${_dio!.options.headers}");
        log("QUERY ::- ${_dio!.options.queryParameters}");
        log("REQUEST ::- $data");
        log("BODY ::- ${options.data}");
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // Do something with response data.
        return handler.next(response);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        // Do something with response error.

        if (e.response?.statusCode == 401 && hasTryRefresh != true) {
          hasTryRefresh = true;
          log("$e --------------- 401 error recalling for refresh token error ------------");
          final response =
              await getx.Get.find<AuthService>().refreshAuthToken();
          if (!response.success) {
            final _ = getx.Get.lazyPut(() => ProfileController());
            return getx.Get.find<ProfileController>().clearData();
          } else {
            userData.token = response.data['token'];
            userData.refreshToken = response.data['refreshToken'];
            AppSettings.updateLocalUserData(userData.toJson());
          }

          krequest(
            endPoint: data['endPoint'],
            method: (data['method'] as Methods),
            query: data['query'],
            body: data['body'],
          );
        }
        if (hasTryRefresh) {
          hasTryRefresh = false;
          if (getx.Get.currentRoute == '/login') {
            return getx.Get.offAllNamed(AppRoutes.name(RouteName.login));
          }
        }
        return handler.next(e);
      },
    );
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

      // preparing the request for interceptor
      final Map<String, dynamic> _request = {
        "method": method,
        "endPoint": endPoint,
        "body": body,
        "query": query,
      };

      // checking if the data is null or not
      if (_request['body'] == null) _request.remove('body');
      if (_request['query'] == null) _request.remove('query');

      // Adding inteceptor
      _dio!.interceptors.add(
        _interceptor(_request),
      );

      Response? response;
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
            message: "Cannot process data at the moment", success: false);
      }

      return resp;
    } catch (e) {
      getx.GetUtils.printFunction("error", e, "error");
      if (e is DioException) {
        return handleDioError(e);
      }
      return RequestResponsModel(message: e.toString());
    }
  }

  static Future<RequestResponsModel> uploadImage({
    required File filePath,
    // required UploadType imageUploadType,
    dynamic controller,
    ImageType fileType = ImageType.IMAGE,
  }) async {
    final headers = {
      "Content-Type": "multipart/form-data",
      'authorization': "Bearer ${userData.token}"
    };

    // dio.MultipartFile.fromBytes(ImageAbstraction.resizeImage(avatar!),
    //     contentType: MediaType("image", "png"), filename: "avatar.png");
    // var formData = dio.FormData();

    _dioOption.receiveTimeout = const Duration(seconds: 300);
    _dio = Dio(_dioOption..headers = headers);
    final image = await MultipartFile.fromFile(
      filePath.path,
      contentType: fileType == ImageType.IMAGE
          ? MediaType('image', 'png')
          : MediaType('application', 'pdf'),
    );

    try {
      var formData = FormData();
      // formData.fields.add(MapEntry('path', imageUploadType.name));
      formData.files.add(MapEntry('image', image));

      final response = await _dio?.post(
        EndPoint.uploadImage,
        data: formData,
        onSendProgress: (count, total) {
          log('$count --- $total');
          if (controller != null) {
            controller.uploadProgress(
                (count.toDouble() / 1000) / (total.toDouble() / 1000) - .23);
          }
        },
      );
      if (controller != null) controller.uploadProgress(0.0);

      RequestResponsModel resp = RequestResponsModel.fromJson(response?.data);

      if (resp.success) {
        AppSettings.addUploadedImageUrlToStorage(value: resp.data);
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
        message: "Server connection timeout, please try again",
        statusCode: error.response?.data?['statusCode'],
        success: error.response?.data?['success'] ?? false,
      );
    } else if (error.type == DioExceptionType.sendTimeout) {
      // Handle send timeout error
      log('Send timeout error: ${error.message}');
      return RequestResponsModel(
          message: "Server not responding, please try again");
    } else if (error.type == DioExceptionType.receiveTimeout) {
      // Handle receive timeout error
      log('Receive timeout error: ${error.message}');
      return RequestResponsModel(
        message: "Server timeout, please try again",
        statusCode: error.response?.data?['statusCode'],
        success: error.response?.data?['success'] ?? false,
      );
    } else if (error.type == DioExceptionType.unknown) {
      log('Response unknown error: ${error.message}');
      log('Response unknown status code: ${error.response?.statusCode}');
      log('Response unknown data: ${error.response?.data}');
      if (error.response?.statusCode == 401 && hasTryRefresh == false) {
        return RequestResponsModel(message: "Checking ...", success: true);
      }
      return RequestResponsModel(
          message: "Unknown Server error, please try again");
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
}

// enum UploadType { Profile, Document, Product, Portfolio, Signature }

enum ImageType { PDF, IMAGE }
