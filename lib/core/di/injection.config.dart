// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:study_hub/core/di/network_module.dart' as _i302;
import 'package:study_hub/core/global_data/global_theme/bloc/theme_bloc.dart'
    as _i447;
import 'package:study_hub/core/network/internet/cubit/connectivity_cubit.dart'
    as _i504;
import 'package:study_hub/core/routing/navigation_service.dart' as _i848;
import 'package:study_hub/features/bottom_nav/presentation/bloc/main_bottom_nav_bloc.dart'
    as _i73;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.factory<_i447.ThemeBloc>(() => _i447.ThemeBloc());
    gh.factory<_i504.ConnectivityCubit>(() => _i504.ConnectivityCubit());
    gh.factory<_i73.MainBottomNavBloc>(() => _i73.MainBottomNavBloc());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i848.NavigationService>(() => _i848.NavigationService());
    return this;
  }
}

class _$NetworkModule extends _i302.NetworkModule {}
