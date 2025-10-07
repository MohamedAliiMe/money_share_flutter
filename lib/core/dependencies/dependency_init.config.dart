// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/home/logic/groups_cubit.dart' as _i489;
import '../../features/authentication/data/repositories/authentication_repository.dart'
    as _i914;
import '../../features/authentication/data/services/authentication_service.dart'
    as _i894;
import '../../features/authentication/logic/authentication_cubit.dart' as _i854;
import '../../features/nav/logic/nav_cubit.dart' as _i106;
import '../../features/profile/data/services/profile_service.dart' as _i510;
import '../../features/profile/logic/profile_cubit.dart' as _i559;
import '../../features/home/domain/repositories/group_repository.dart' as _i879;
import '../../features/home/domain/service/group_service.dart' as _i607;
import '../utilities/app_data_storage.dart' as _i102;
import '../utilities/configs/themes/theme_cubit.dart' as _i691;
import 'Module/register_module.dart' as _i773;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i102.DataStorage>(() => _i102.DataStorage());
  gh.factory<_i691.ThemeCubit>(() => _i691.ThemeCubit());
  gh.factory<_i106.NavCubit>(() => _i106.NavCubit());
  gh.factory<_i559.ProfileCubit>(() => _i559.ProfileCubit());
  gh.factory<String>(
    () => registerModule.baseUrl,
    instanceName: 'BaseUrl',
  );
  gh.lazySingleton<_i361.Dio>(
    () => registerModule.dio(gh<String>(instanceName: 'BaseUrl')),
    instanceName: 'Dio',
  );
  gh.lazySingleton<_i894.AuthenticationService>(
      () => _i894.AuthenticationService(gh<_i361.Dio>(instanceName: 'Dio')));
  gh.lazySingleton<_i510.ProfileService>(
      () => _i510.ProfileService(gh<_i361.Dio>(instanceName: 'Dio')));
  gh.lazySingleton<_i607.GroupService>(
      () => _i607.GroupService(gh<_i361.Dio>(instanceName: 'Dio')));
  gh.lazySingleton<_i361.Dio>(
    () => registerModule.dioInterceptor(gh<String>(instanceName: 'BaseUrl')),
    instanceName: 'Interceptor',
  );
  gh.lazySingleton<_i914.AuthenticationRepository>(
      () => _i914.AuthenticationRepository(gh<_i894.AuthenticationService>()));
  gh.factory<_i854.AuthenticationCubit>(
      () => _i854.AuthenticationCubit(gh<_i914.AuthenticationRepository>()));
  gh.lazySingleton<_i879.GroupRepository>(
      () => _i879.GroupRepository(gh<_i607.GroupService>()));
  gh.factory<_i489.GroupsCubit>(
      () => _i489.GroupsCubit(gh<_i879.GroupRepository>()));
  return getIt;
}

class _$RegisterModule extends _i773.RegisterModule {}
