import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:splitwise_flutter/core/constants/app_string_constants.dart';
import 'package:splitwise_flutter/core/utilities/appKeys.dart';


class ApiInterceptors extends Interceptor {
  final Dio _dio;

  late Box box;

  ApiInterceptors(this._dio) {
    initHive();
   _addDioInterceptor();
  }

  Future<void> initHive() async {
    box = await Hive.openBox(AppStringConstants.appName);
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);

     options.headers.addAll(
        {AppStringConstants.platform: AppStringConstants.mobilePlatform});

    // get tokens from local storage, you can use Hive or flutter_secure_storage
    final customerAccessToken =
        await box.get(AppStringConstants.userAccessToken);
    var accessToken = customerAccessToken;

    log("accessToken $accessToken");
    options.headers["Authorization"] = "Bearer $accessToken";
    options.headers["Accept"] = "application/json";
    options.headers["Accept-Language"] = _getCurrentPathLanguage();
  }

  static String _getCurrentPathLanguage() {
    return AppKeys.materialKey.currentContext!.locale.languageCode;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
            _performLogout(_dio);
    }
    handler.next(err);
  }

  void _performLogout(Dio dio) async {
  //  getIt<AuthenticationCubit>().add(AuthenticationCubit.logOut());
  }

  void _addDioInterceptor() {
    _dio.interceptors.add(PrettyDioLogger(
        compact: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        enabled: true,
        maxWidth: 80,
        logPrint: (Object object) {
          log(object.toString());
        }));
  }
}
