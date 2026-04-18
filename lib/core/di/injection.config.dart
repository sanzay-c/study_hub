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
import 'package:study_hub/features/auth/domain/usecase/delete_account_usecase.dart'
    as _i235;
import 'package:study_hub/features/auth/domain/usecase/login_usecasse.dart'
    as _i1006;
import 'package:study_hub/features/auth/domain/usecase/logout_usecase.dart'
    as _i558;
import 'package:study_hub/features/auth/domain/usecase/request_reset_usecase.dart'
    as _i869;
import 'package:study_hub/features/auth/domain/usecase/reset_password_usecase.dart'
    as _i677;
import 'package:study_hub/features/auth/domain/usecase/signup_usecase.dart'
    as _i188;
import 'package:study_hub/features/auth/domain/usecase/verify_otp_usecase.dart'
    as _i215;
import 'package:study_hub/features/auth/presentation/bloc/auth_bloc.dart'
    as _i553;
import 'package:study_hub/features/auth/presentation/cubit/forgot_password_cubit.dart'
    as _i872;
import 'package:study_hub/features/bottom_nav/presentation/bloc/main_bottom_nav_bloc.dart'
    as _i73;
import 'package:study_hub/features/chat/data/datasource/chat_remote_datasource.dart'
    as _i136;
import 'package:study_hub/features/chat/data/repo_impl/chat_repository_impl.dart'
    as _i864;
import 'package:study_hub/features/chat/domain/repo/chat_repository.dart'
    as _i707;
import 'package:study_hub/features/chat/domain/usecase/close_chat_connection_usecase.dart'
    as _i608;
import 'package:study_hub/features/chat/domain/usecase/connect_chat_usecase.dart'
    as _i685;
import 'package:study_hub/features/chat/domain/usecase/get_chat_history_usecase.dart'
    as _i322;
import 'package:study_hub/features/chat/domain/usecase/get_unified_chat_list_usecase.dart'
    as _i961;
import 'package:study_hub/features/chat/domain/usecase/mark_as_read_usecase.dart'
    as _i535;
import 'package:study_hub/features/chat/domain/usecase/send_message_usecase.dart'
    as _i341;
import 'package:study_hub/features/chat/presentation/bloc/chat_bloc.dart'
    as _i707;
import 'package:study_hub/features/groups/data/datasource/groups_remote_datasource.dart'
    as _i170;
import 'package:study_hub/features/groups/data/repo_impl/groups_repository_impl.dart'
    as _i633;
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart'
    as _i1011;
import 'package:study_hub/features/groups/domain/usecase/delete_group_usecase.dart'
    as _i49;
import 'package:study_hub/features/groups/domain/usecase/get_all_groups_usecase.dart'
    as _i111;
import 'package:study_hub/features/groups/domain/usecase/get_groups_detail_usecase.dart'
    as _i461;
import 'package:study_hub/features/groups/domain/usecase/get_groups_usecase.dart'
    as _i809;
import 'package:study_hub/features/groups/domain/usecase/join_group_usecase.dart'
    as _i581;
import 'package:study_hub/features/groups/domain/usecase/leave_group_usecase.dart'
    as _i599;
import 'package:study_hub/features/groups/domain/usecase/remove_member_usecase.dart'
    as _i402;
import 'package:study_hub/features/groups/domain/usecase/update_group_usecase.dart'
    as _i571;
import 'package:study_hub/features/groups/presentation/cubit/create_group_cubit.dart'
    as _i399;
import 'package:study_hub/features/groups/presentation/cubit/group_detail_cubit.dart'
    as _i74;
import 'package:study_hub/features/groups/presentation/cubit/groups_cubit.dart'
    as _i690;
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
import 'package:study_hub/features/notes/domain/usecase/upload_note_usecase.dart'
    as _i758;
import 'package:study_hub/features/notes/presentation/bloc/notes_bloc.dart'
    as _i348;
import 'package:study_hub/features/notes/presentation/cubit-upload-note/upload_note_cubit.dart'
    as _i760;
import 'package:study_hub/features/social/data/datasource/social_remote_datasource.dart'
    as _i615;
import 'package:study_hub/features/social/data/repo_impl/social_repo_impl.dart'
    as _i730;
import 'package:study_hub/features/social/domain/repo/social_repo.dart'
    as _i430;
import 'package:study_hub/features/social/domain/usecase/follow_user_usecase.dart'
    as _i118;
import 'package:study_hub/features/social/domain/usecase/get_user_stats_usecase.dart'
    as _i443;
import 'package:study_hub/features/social/domain/usecase/social_discover_usecase.dart'
    as _i925;
import 'package:study_hub/features/social/domain/usecase/social_followers_usecase.dart'
    as _i824;
import 'package:study_hub/features/social/domain/usecase/social_following_usecase.dart'
    as _i503;
import 'package:study_hub/features/social/domain/usecase/unfollow_user_usecase.dart'
    as _i256;
import 'package:study_hub/features/social/presentation/bloc/social_bloc.dart'
    as _i847;
import 'package:study_hub/features/social/presentation/cubit/user_stats_cubit.dart'
    as _i842;
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
    gh.lazySingleton<_i136.ChatRemoteDataSource>(
      () => _i136.ChatRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i615.SocialRemoteDataSource>(
      () => _i615.SocialRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i230.AuthDatasource>(
      () => _i230.AuthDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i170.GroupsRemoteDataSource>(
      () => _i170.GroupsRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1011.GroupsRepository>(
      () => _i633.GroupsRepositoryImpl(
        remoteDataSource: gh<_i170.GroupsRemoteDataSource>(),
      ),
    );
    gh.factory<_i111.GetAllGroupsUsecase>(
      () => _i111.GetAllGroupsUsecase(gh<_i1011.GroupsRepository>()),
    );
    gh.factory<_i461.GetGroupDetailsUseCase>(
      () => _i461.GetGroupDetailsUseCase(gh<_i1011.GroupsRepository>()),
    );
    gh.factory<_i581.JoinGroupUseCase>(
      () => _i581.JoinGroupUseCase(gh<_i1011.GroupsRepository>()),
    );
    gh.factory<_i599.LeaveGroupUseCase>(
      () => _i599.LeaveGroupUseCase(gh<_i1011.GroupsRepository>()),
    );
    gh.lazySingleton<_i49.DeleteGroupUseCase>(
      () => _i49.DeleteGroupUseCase(gh<_i1011.GroupsRepository>()),
    );
    gh.lazySingleton<_i402.RemoveMemberUseCase>(
      () => _i402.RemoveMemberUseCase(gh<_i1011.GroupsRepository>()),
    );
    gh.lazySingleton<_i571.UpdateGroupUseCase>(
      () => _i571.UpdateGroupUseCase(gh<_i1011.GroupsRepository>()),
    );
    gh.lazySingleton<_i430.SocialRepo>(
      () => _i730.SocialRepoImpl(
        socialRemoteDataSource: gh<_i615.SocialRemoteDataSource>(),
      ),
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
    gh.lazySingleton<_i707.ChatRepository>(
      () => _i864.ChatRepositoryImpl(
        remoteDataSource: gh<_i136.ChatRemoteDataSource>(),
      ),
    );
    gh.factory<_i1006.LoginUsecase>(
      () => _i1006.LoginUsecase(gh<_i481.AuthRepo>()),
    );
    gh.factory<_i558.LogoutUsecase>(
      () => _i558.LogoutUsecase(gh<_i481.AuthRepo>()),
    );
    gh.factory<_i869.RequestResetUseCase>(
      () => _i869.RequestResetUseCase(gh<_i481.AuthRepo>()),
    );
    gh.factory<_i677.ResetPasswordUseCase>(
      () => _i677.ResetPasswordUseCase(gh<_i481.AuthRepo>()),
    );
    gh.factory<_i215.VerifyOTPUseCase>(
      () => _i215.VerifyOTPUseCase(gh<_i481.AuthRepo>()),
    );
    gh.lazySingleton<_i235.DeleteAccountUseCase>(
      () => _i235.DeleteAccountUseCase(gh<_i481.AuthRepo>()),
    );
    gh.lazySingleton<_i872.ForgotPasswordCubit>(
      () => _i872.ForgotPasswordCubit(
        gh<_i869.RequestResetUseCase>(),
        gh<_i215.VerifyOTPUseCase>(),
        gh<_i677.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i118.FollowUserUsecase>(
      () => _i118.FollowUserUsecase(repository: gh<_i430.SocialRepo>()),
    );
    gh.factory<_i256.UnfollowUserUsecase>(
      () => _i256.UnfollowUserUsecase(repository: gh<_i430.SocialRepo>()),
    );
    gh.factory<_i970.UploadAvatarCubit>(
      () => _i970.UploadAvatarCubit(gh<_i481.AuthRepo>()),
    );
    gh.factory<_i399.CreateGroupCubit>(
      () => _i399.CreateGroupCubit(
        gh<_i1011.GroupsRepository>(),
        gh<_i571.UpdateGroupUseCase>(),
      ),
    );
    gh.factory<_i74.GroupDetailCubit>(
      () => _i74.GroupDetailCubit(
        getGroupDetailsUseCase: gh<_i461.GetGroupDetailsUseCase>(),
        joinGroupUseCase: gh<_i581.JoinGroupUseCase>(),
        leaveGroupUseCase: gh<_i599.LeaveGroupUseCase>(),
        deleteGroupUseCase: gh<_i49.DeleteGroupUseCase>(),
        removeMemberUseCase: gh<_i402.RemoveMemberUseCase>(),
      ),
    );
    gh.factory<_i809.GetGroupsUseCase>(
      () => _i809.GetGroupsUseCase(repository: gh<_i1011.GroupsRepository>()),
    );
    gh.lazySingleton<_i608.CloseChatConnectionUseCase>(
      () => _i608.CloseChatConnectionUseCase(gh<_i707.ChatRepository>()),
    );
    gh.lazySingleton<_i685.ConnectChatUseCase>(
      () => _i685.ConnectChatUseCase(gh<_i707.ChatRepository>()),
    );
    gh.lazySingleton<_i322.GetChatHistoryUseCase>(
      () => _i322.GetChatHistoryUseCase(gh<_i707.ChatRepository>()),
    );
    gh.lazySingleton<_i535.MarkAsReadUseCase>(
      () => _i535.MarkAsReadUseCase(gh<_i707.ChatRepository>()),
    );
    gh.lazySingleton<_i341.SendChatMessageUseCase>(
      () => _i341.SendChatMessageUseCase(gh<_i707.ChatRepository>()),
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
    gh.factory<_i758.UploadNoteUseCase>(
      () => _i758.UploadNoteUseCase(repository: gh<_i689.NotesRepo>()),
    );
    gh.factory<_i443.GetUserStatsUsecase>(
      () => _i443.GetUserStatsUsecase(gh<_i430.SocialRepo>()),
    );
    gh.factory<_i925.SocialDiscoverUsecase>(
      () => _i925.SocialDiscoverUsecase(gh<_i430.SocialRepo>()),
    );
    gh.factory<_i824.SocialFollowersUsecase>(
      () => _i824.SocialFollowersUsecase(gh<_i430.SocialRepo>()),
    );
    gh.factory<_i503.SocialFollowingUsecase>(
      () => _i503.SocialFollowingUsecase(gh<_i430.SocialRepo>()),
    );
    gh.lazySingleton<_i188.SignupUsecase>(
      () => _i188.SignupUsecase(authRepo: gh<_i481.AuthRepo>()),
    );
    gh.lazySingleton<_i961.GetUnifiedChatListUseCase>(
      () => _i961.GetUnifiedChatListUseCase(
        groupsRepository: gh<_i1011.GroupsRepository>(),
        chatRepository: gh<_i707.ChatRepository>(),
      ),
    );
    gh.factory<_i760.UploadNoteCubit>(
      () => _i760.UploadNoteCubit(
        uploadNoteUseCase: gh<_i758.UploadNoteUseCase>(),
      ),
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
        gh<_i235.DeleteAccountUseCase>(),
      ),
    );
    gh.factory<_i847.SocialBloc>(
      () => _i847.SocialBloc(
        getFollowersUsecase: gh<_i824.SocialFollowersUsecase>(),
        getFollowingUsecase: gh<_i503.SocialFollowingUsecase>(),
        getDiscoverUsecase: gh<_i925.SocialDiscoverUsecase>(),
        followUserUsecase: gh<_i118.FollowUserUsecase>(),
        unfollowUserUsecase: gh<_i256.UnfollowUserUsecase>(),
      ),
    );
    gh.factory<_i707.ChatBloc>(
      () => _i707.ChatBloc(
        gh<_i322.GetChatHistoryUseCase>(),
        gh<_i685.ConnectChatUseCase>(),
        gh<_i341.SendChatMessageUseCase>(),
        gh<_i608.CloseChatConnectionUseCase>(),
      ),
    );
    gh.factory<_i348.NotesBloc>(
      () => _i348.NotesBloc(
        gh<_i1000.GetDiscoverNotesUsecase>(),
        gh<_i261.GetMyNotesUseCase>(),
        gh<_i546.DownloadNoteUseCase>(),
      ),
    );
    gh.factory<_i842.UserStatsCubit>(
      () => _i842.UserStatsCubit(gh<_i443.GetUserStatsUsecase>()),
    );
    gh.factory<_i690.GroupsCubit>(
      () => _i690.GroupsCubit(
        getGroupsUseCase: gh<_i809.GetGroupsUseCase>(),
        getAllGroupsUsecase: gh<_i111.GetAllGroupsUsecase>(),
        markAsReadUseCase: gh<_i535.MarkAsReadUseCase>(),
        getUnifiedChatListUseCase: gh<_i961.GetUnifiedChatListUseCase>(),
      ),
    );
    gh.factory<_i566.UserStatsBloc>(
      () => _i566.UserStatsBloc(gh<_i1067.GetUserStatsUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i302.NetworkModule {}
