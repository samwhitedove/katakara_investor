// ignore_for_file: no_leading_underscores_for_local_identifiers, constant_identifier_names

import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/helper/helper.dart';
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

  static getx.RxBool hasTryRefresh = false.obs;

  static cancelAllConnection() {
    cancelToken?.cancel();
  }

  static InterceptorsWrapper _interceptor() {
    return InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        log("HEADER ::- ${_dio!.options.headers}");
        log("QUERY ::- ${_dio!.options.queryParameters}");
        log("REQUEST DATA::- ${options.data}");
        log("BODY ::- ${options.data}");
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        return handler.next(response);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        if (e.response?.statusCode == 401 && !hasTryRefresh.value) {
          await _refreshTokenAndRetry(e, handler);
        } else {
          return handler.next(e);
        }
      },
    );
  }

  static Future<void> _refreshTokenAndRetry(
      DioException e, ErrorInterceptorHandler handler) async {
    hasTryRefresh.value = true;
    log("$e --------------- 401 error recalling for refresh token error ------------");

    final response = await AuthService().refreshAuthToken();

    if (response.success) {
      _updateToken(response.data['token'], response.data['refreshToken']);
      return await _retryOriginalRequest(e.requestOptions);
    }
    return await _handleTokenRefreshFailure();
  }

  static void _updateToken(String token, String refreshToken) {
    userData.token = token;
    userData.refreshToken = refreshToken;
    AppSettings.updateLocalUserData(userData.toJson());
  }

  static Future<void> _handleTokenRefreshFailure() async {
    final _ = getx.Get.lazyPut(() => ProfileController());
    await getx.Get.find<ProfileController>().clearData();
  }

  static Future<void> _retryOriginalRequest(
      RequestOptions requestOptions) async {
    await _dio!.request(
      requestOptions.path,
      data: requestOptions.data,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      ),
    );
  }

  static Future krequest({
    required String endPoint,
    required Methods method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    log('$endPoint query: $query body: $body ------- endpoint');
    try {
      final headers = {
        "Content-Type": "application/json",
        'authorization': "Bearer ${userData.token}"
      };

      _dio = Dio(_dioOption..headers = headers);

      log('${_dio!.options.extra.entries} ------- options');

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
      _dio!.interceptors.add(_interceptor());

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

      RequestResponseModel resp = RequestResponseModel.fromJson(response!.data);
      // log(resp.toJson().toString());

      if (resp.statusCode == 500) {
        return RequestResponseModel(
            message: "Cannot process data at the moment", success: false);
      }
      log("${response.statusCode} $endPoint -----request success");
      return resp;
    } catch (e) {
      getx.GetUtils.printFunction("error", e, "error");
      if (e is DioException) {
        return handleDioError(e, endPoint);
      }
      return RequestResponseModel(message: e.toString());
    }
  }

  static Future<RequestResponseModel> uploadImage({
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

      RequestResponseModel resp = RequestResponseModel.fromJson(response?.data);

      if (resp.success) {
        AppSettings.addUploadedImageUrlToStorage(value: resp.data);
      }

      return resp;
    } catch (e) {
      log(e.toString());
      log('$e--------- 2 2 2 2');
      if (e is DioException) {
        return handleDioError(e, "File Uplaod endpoint");
      }
      return RequestResponseModel(message: e.toString(), success: false);
    }
  }

  static RequestResponseModel handleDioError(DioException error, String end) {
    log('--------------- its dio error ${error.type}');
    log('--------------- its dio error ${error.message}');
    log('--------------- its dio error ${end}');
    if (error.type == DioExceptionType.connectionTimeout) {
      return RequestResponseModel(
        message: "Server connection timeout, please try again",
        statusCode: error.response?.data?['statusCode'],
        success: error.response?.data?['success'] ?? false,
      );
    } else if (error.type == DioExceptionType.sendTimeout) {
      // Handle send timeout error
      return RequestResponseModel(
          message: "Server not responding, please try again");
    } else if (error.type == DioExceptionType.receiveTimeout) {
      // Handle receive timeout error
      return RequestResponseModel(
        message: "Server timeout, please try again",
        statusCode: error.response?.data?['statusCode'],
        success: error.response?.data?['success'] ?? false,
      );
    } else if (error.type == DioExceptionType.unknown) {
      log('Response unknown status code: ${error.response?.statusCode}');
      log('Response unknown data: ${error.response?.data}');
      log('$end throw the errors ------------------ endpoint error');
      if (error.response?.statusCode == 401 && hasTryRefresh.value == false) {
        return RequestResponseModel(message: "Checking ...", success: true);
      }
      return RequestResponseModel(
          message: "Unknown Server error, please try again");
    } else if (error.type == DioExceptionType.badResponse) {
      // Handle response error
      log('Response bad request status code: ${error.response?.statusCode}');
      log('Response bad request data: ${error.response?.data}');
      return RequestResponseModel(
        message: error.response?.data?['message'],
        statusCode: error.response?.data?['statusCode'],
        success: error.response?.data?['success'] ?? false,
      );
    } else if (error.type == DioExceptionType.cancel) {
      // Handle request cancellation
      return RequestResponseModel(message: error.message);
    } else if (error.type == DioExceptionType.connectionError) {
      // Handle request cancellation
      return RequestResponseModel(
          message: "Error in connection, check internet");
    } else {
      // Handle other Dio errors
      return RequestResponseModel(message: error.message);
    }
  }
}

// enum UploadType { Profile, Document, Product, Portfolio, Signature }

enum ImageType { PDF, IMAGE }
