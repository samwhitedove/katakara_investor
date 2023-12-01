// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:get/get.dart' as getx;

// import '../helper/helper.settings.dart';
// import '../models/services/model.service.response.dart';
// import '../values/strings.dart';
// import '../view/home/home.dart';
// import 'services.auth.dart';

// class ApiRequest {
//   static Dio? _dio;
//   static final dioOption = BaseOptions(
//     baseUrl: 'your_base_url',
//   );

//   static getx.RxBool hasTryRefresh = false.obs;

//   static InterceptorsWrapper _interceptor() {
//     return InterceptorsWrapper(
//       onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
//         log("HEADER ::- ${_dio!.options.headers}");
//         log("QUERY ::- ${_dio!.options.queryParameters}");
//         log("REQUEST ::- ${options.data}");
//         log("BODY ::- ${options.data}");
//         return handler.next(options);
//       },
//       onResponse: (Response response, ResponseInterceptorHandler handler) {
//         return handler.next(response);
//       },
//       onError: (DioException e, ErrorInterceptorHandler handler) async {
//         if (e.response?.statusCode == 401 && !hasTryRefresh.value) {
//           await _refreshTokenAndRetry(e, handler);
//         } else {
//           return handler.next(e);
//         }
//       },
//     );
//   }

//   static Future<void> _refreshTokenAndRetry(
//       DioException e, ErrorInterceptorHandler handler) async {
//     hasTryRefresh.value = true;
//     log("$e --------------- 401 error recalling for refresh token error ------------");

//     final response = await AuthService().refreshAuthToken();

//     if (!response.success) {
//       await _handleTokenRefreshFailure();
//     } else {
//       _updateToken(response.data['token'], response.data['refreshToken']);
//       await _retryOriginalRequest(e.requestOptions);
//     }
//   }

//   static void _updateToken(String token, String refreshToken) {
//     userData.token = token;
//     userData.refreshToken = refreshToken;
//     AppSettings.updateLocalUserData(userData.toJson());
//   }

//   static Future<void> _handleTokenRefreshFailure() async {
//     final _ = getx.Get.lazyPut(() => ProfileController());
//     await getx.Get.find<ProfileController>().clearData();
//   }

//   static Future<void> _retryOriginalRequest(
//       RequestOptions requestOptions) async {
//     await _dio!.request(
//       requestOptions.path,
//       options: requestOptions as Options,
//     );
//   }

//   static Future<RequestResponsModel> krequest({
//     required String endPoint,
//     required Methods method,
//     Map<String, dynamic>? body,
//     Map<String, dynamic>? query,
//   }) async {
//     log(endPoint);

//     try {
//       final headers = {
//         "Content-Type": "application/json",
//         'authorization': "Bearer ${userData.token}"
//       };

//       _dio = Dio(dioOption..headers = headers);

//       _dio!.interceptors.add(_interceptor());

//       Response response;

//       switch (method) {
//         case Methods.post:
//           response = await _dio!.post(endPoint, data: body);
//           break;
//         case Methods.get:
//           response = await _dio!.get(endPoint, queryParameters: query);
//           break;
//         case Methods.put:
//           response = await _dio!.put(endPoint, data: body);
//           break;
//         case Methods.delete:
//           response = await _dio!.delete(endPoint, data: body);
//           break;
//         case Methods.patch:
//           response = await _dio!.patch(endPoint, data: body);
//           break;
//         default:
//           throw 'Invalid request method';
//       }

//       RequestResponsModel resp = RequestResponsModel.fromJson(response.data);
//       log(resp.toJson().toString());

//       if (resp.statusCode == 500) {
//         return RequestResponsModel(
//             message: "Cannot process data at the moment", success: false);
//       }

//       return resp;
//     } catch (e) {
//       getx.GetUtils.printFunction("error", e, "error");
//       if (e is DioError) {
//         // return handleDioError(e);
//       }
//       return RequestResponsModel(message: e.toString());
//     }
//   }
// }
