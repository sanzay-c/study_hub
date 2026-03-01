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
import 'package:study_hub/core/services/local/auth_database.dart' as _i274;
import 'package:study_hub/core/services/local/database/daos/auth_dao.dart'
    as _i284;
import 'package:study_hub/features/auth/data/datasource/auth_datasource.dart'
    as _i230;
import 'package:study_hub/features/auth/data/datasource/auth_local_datasource.dart'
    as _i394;
import 'package:study_hub/features/auth/data/repo_impl/auth_repo_impl.dart'
    as _i658;
import 'package:study_hub/features/auth/domain/repo/auth_repo.dart' as _i481;
import 'package:study_hub/features/auth/domain/usecase/login_usecasse.dart'
    as _i1006;
import 'package:study_hub/features/auth/domain/usecase/logout_usecase.dart'
    as _i558;
import 'package:study_hub/features/auth/domain/usecase/signup_usecase.dart'
    as _i188;
import 'package:study_hub/features/auth/presentation/bloc/auth_bloc.dart'
    as _i553;
import 'package:study_hub/features/bottom_nav/presentation/bloc/main_bottom_nav_bloc.dart'
    as _i73;
import 'package:study_hub/features/notes/data/datasource/notes_remote_datasource.dart'
    as _i900;
import 'package:study_hub/features/notes/data/repo_impl/notes_repo_impl.dart'
    as _i563;
import 'package:study_hub/features/notes/domain/repo/notes_repo.dart' as _i689;
import 'package:study_hub/features/notes/domain/usecase/download_note_usecase.dart'
    as _i546;
import 'package:study_hub/features/notes/domain/usecase/get_discover_notes_usecase.dart'
    as _i1000;
import 'package:study_hub/features/notes/domain/usecase/get_my_notes_usecase.dart'
    as _i261;
import 'package:study_hub/features/notes/presentation/bloc/notes_bloc.dart'
    as _i348;
import 'package:study_hub/features/upload_avatar/presentation/cubit/upload_avatar_cubit.dart'
    as _i970;
import 'package:study_hub/features/user_stats/data/datasource/user_stats_remote_datasource.dart'
    as _i199;
import 'package:study_hub/features/user_stats/data/repo_impl/user_stats_repository_impl.dart'
    as _i282;
import 'package:study_hub/features/user_stats/domain/repo/user_stats_repository.dart'
    as _i117;
import 'package:study_hub/features/user_stats/domain/usecase/get_user_stats_usecase.dart'
    as _i1067;
import 'package:study_hub/features/user_stats/presentation/bloc/user_stats_bloc.dart'
    as _i566;

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
    gh.lazySingleton<_i274.AppDatabase>(() => networkModule.database);
    gh.lazySingleton<_i848.NavigationService>(() => _i848.NavigationService());
    gh.lazySingleton<_i284.AuthDao>(
      () => networkModule.authDao(gh<_i274.AppDatabase>()),
    );
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio(gh<_i284.AuthDao>()));
    gh.lazySingleton<_i394.AuthLocalDataSource>(
      () => _i394.AuthLocalDataSourceImpl(gh<_i284.AuthDao>()),
    );
    gh.lazySingleton<_i900.NoteRemoteDataSource>(
      () => _i900.NoteRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i199.UserStatsRemoteDataSource>(
      () => _i199.UserStatsRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i230.AuthDatasource>(
      () => _i230.AuthDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i117.UserStatsRepository>(
      () =>
          _i282.UserStatsRepositoryImpl(gh<_i199.UserStatsRemoteDataSource>()),
    );
    gh.lazySingleton<_i689.NotesRepo>(
      () => _i563.NotesRepoImpl(
        noteRemoteDataSource: gh<_i900.NoteRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i481.AuthRepo>(
      () => _i658.AuthRepoImpl(
        gh<_i230.AuthDatasource>(),
        gh<_i394.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i1006.LoginUsecase>(
      () => _i1006.LoginUsecase(gh<_i481.AuthRepo>()),
    );
    gh.factory<_i558.LogoutUsecase>(
      () => _i558.LogoutUsecase(gh<_i481.AuthRepo>()),
    );
    gh.factory<_i970.UploadAvatarCubit>(
      () => _i970.UploadAvatarCubit(gh<_i481.AuthRepo>()),
    );
    gh.factory<_i546.DownloadNoteUseCase>(
      () => _i546.DownloadNoteUseCase(repository: gh<_i689.NotesRepo>()),
    );
    gh.factory<_i1000.GetDiscoverNotesUsecase>(
      () => _i1000.GetDiscoverNotesUsecase(repository: gh<_i689.NotesRepo>()),
    );
    gh.factory<_i261.GetMyNotesUseCase>(
      () => _i261.GetMyNotesUseCase(repository: gh<_i689.NotesRepo>()),
    );
    gh.lazySingleton<_i188.SignupUsecase>(
      () => _i188.SignupUsecase(authRepo: gh<_i481.AuthRepo>()),
    );
    gh.lazySingleton<_i1067.GetUserStatsUseCase>(
      () => _i1067.GetUserStatsUseCase(gh<_i117.UserStatsRepository>()),
    );
    gh.factory<_i553.AuthBloc>(
      () => _i553.AuthBloc(
        gh<_i188.SignupUsecase>(),
        gh<_i1006.LoginUsecase>(),
        gh<_i481.AuthRepo>(),
        gh<_i558.LogoutUsecase>(),
      ),
    );
    gh.factory<_i348.NotesBloc>(
      () => _i348.NotesBloc(
        gh<_i1000.GetDiscoverNotesUsecase>(),
        gh<_i261.GetMyNotesUseCase>(),
        gh<_i546.DownloadNoteUseCase>(),
      ),
    );
    gh.factory<_i566.UserStatsBloc>(
      () => _i566.UserStatsBloc(gh<_i1067.GetUserStatsUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i302.NetworkModule {}
