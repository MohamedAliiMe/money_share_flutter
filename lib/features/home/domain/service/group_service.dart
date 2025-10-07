import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:splitwise_flutter/core/data/data_list_response/base_data_list_response.dart';
import 'package:splitwise_flutter/core/networking/api_path.dart';
import 'package:splitwise_flutter/features/home/domain/model/group.dart';

part 'group_service.g.dart';

@RestApi(baseUrl: AppApiPaths.baseUrl)
@lazySingleton
abstract class GroupService {
  @factoryMethod
  factory GroupService(@Named("Dio") Dio dio) = _GroupService;

  @GET(AppApiPaths.groups)
  Future<HttpResponse<List<GroupModel>>> getGroups();

  @POST(AppApiPaths.groups)
  Future<HttpResponse<GroupModel>> createGroup();

  @POST("${AppApiPaths.groups}/{groupId}/members")
  Future<HttpResponse<void>> addMemberToGroup({
    @Path("groupId") required int groupId,
    @Body() required Map<String, dynamic> body,
  });

  @DELETE("${AppApiPaths.groups}/{groupId}/members/{userId}")
  Future<HttpResponse<void>> removeMemberFromGroup({
    @Path("groupId") required int groupId,
    @Path("userId") required int userId,
  });
}
