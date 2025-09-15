import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:splitwise_flutter/core/data/single_item_base_response/single_item_base_response.dart';
import 'package:splitwise_flutter/core/networking/api_path.dart';
import 'package:splitwise_flutter/features/authentication/data/models/login_model/login_model.dart';
import 'package:splitwise_flutter/features/authentication/data/models/login_params/login_params.dart';
import 'package:splitwise_flutter/features/authentication/data/models/regester_params/regester_params.dart';
import 'package:splitwise_flutter/features/authentication/data/models/register_model/register_model.dart';

part 'authentication_service.g.dart';

@RestApi(baseUrl: AppApiPaths.baseUrl)
@lazySingleton
abstract class AuthenticationService {
  @factoryMethod
  factory AuthenticationService(@Named('Dio') Dio dio) =>
      _AuthenticationService(dio);

  @POST(AppApiPaths.loginUrl)
  Future<HttpResponse<SingleItemBaseResponse<LoginModel>>> getLogin({
    @Body() required LoginParams loginParams,
  });

  @POST(AppApiPaths.registerUrl)
  Future<HttpResponse<SingleItemBaseResponse<RegisterModel>>> register({
    @Body() required RegisterParams registerParams,
  });

  // @POST(AppApiPaths.forgetPassword)
  // Future<HttpResponse<SingleItemBaseResponse<RegisterModel>>> forgetPassword({
  //   @Body() required ForgetPasswordParams forgetPasswordParams,
  // });
  // @POST(AppApiPaths.resetPassword)
  // Future<HttpResponse<SingleItemBaseResponse<UserModel>>> restPassword({
  //   @Body() required RestPasswordParams restPasswordParams,
  // });
}
