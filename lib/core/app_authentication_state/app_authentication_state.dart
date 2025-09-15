import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitwise_flutter/core/constants/hive_ids.dart';

part 'app_authentication_state.g.dart';

@HiveType(typeId: HiveIds.appAuthenticationStateId)
enum AppAuthenticationStateEnum {
  @HiveField(0)
  customerState,
  @HiveField(1)
  unauthorizedState,
}
