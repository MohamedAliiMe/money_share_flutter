import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:splitwise_flutter/core/data/data_list_response/base_data_list_response.dart';
import 'package:splitwise_flutter/core/networking/api_path.dart';
import 'package:splitwise_flutter/features/home/domain/model/create_group/create_group_model.dart';
import 'package:splitwise_flutter/features/home/domain/model/delete_group/delete_group_model.dart';
import 'package:splitwise_flutter/features/home/domain/model/groups/group.dart';
import 'package:splitwise_flutter/features/home/domain/model/update_groups/update_groups_model.dart';

part 'group_service.g.dart';

@RestApi(baseUrl: AppApiPaths.baseUrl)
@lazySingleton
abstract class GroupService {
  @factoryMethod
  factory GroupService(@Named("Dio") Dio dio) = _GroupService;

  @GET(AppApiPaths.groups)
  Future<HttpResponse<List<GroupModel>>> getGroups();

  @POST(AppApiPaths.groups)
  Future<HttpResponse<CreateGroupModel>> createGroup({
    @Body() required CreateGroupModel body,
  });

  @DELETE(AppApiPaths.deleteGroups)
  Future<HttpResponse<DeleteGroupModel>> deleteGroup({
    @Path("groupId") required int groupId,
  });

  @PUT(AppApiPaths.updateGroups)
  Future<HttpResponse<UpdateGroupsModel>> updateGroup({
    @Path("groupId") required int groupId,
    @Body() required UpdateGroupsModel body,
  });












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
