import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/chat/domain/usecase/get_unified_chat_list_usecase.dart';
import 'package:study_hub/features/chat/domain/usecase/mark_as_read_usecase.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart';
import 'package:study_hub/features/groups/domain/usecase/get_all_groups_usecase.dart';
import 'package:study_hub/features/groups/domain/usecase/get_groups_usecase.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_state.dart';

@injectable
class GroupsCubit extends Cubit<GroupsState> {
  final GetGroupsUseCase getGroupsUseCase;
  final GetAllGroupsUsecase getAllGroupsUsecase;
  final MarkAsReadUseCase markAsReadUseCase;
  final GetUnifiedChatListUseCase getUnifiedChatListUseCase;

  GroupsCubit({
    required this.getGroupsUseCase,
    required this.getAllGroupsUsecase,
    required this.markAsReadUseCase,
    required this.getUnifiedChatListUseCase,
  }) : super(GroupsInitial());

  Future<void> getGroups() async {
    emit(GroupsLoading());
    try {
      final groups = await getGroupsUseCase();
      emit(GroupsSuccess(groups: groups));
    } catch (e) {
      emit(GroupsError(message: e.toString()));
    }
  }

  Future<void> _fetchGroups({
    required String tab,
    bool loadMore = false,
    int limit = 10,
  }) async {
    if (isClosed) return;

    int pageToFetch = 1;
    List<GetGroupsEntity> currentGroups = [];

    if (loadMore && state is GroupsSuccess) {
      final currentState = state as GroupsSuccess;
      if (!currentState.hasNext) return;
      pageToFetch = currentState.currentPage + 1;
      currentGroups = currentState.getGroups ?? [];
      emit(currentState.copyWith(isLoadMore: true));
    } else {
      emit(GroupsLoading());
    }

    try {
      final result = await getAllGroupsUsecase(tab: tab, page: pageToFetch, limit: limit);
      final List<GetGroupsEntity> newGroups = result.results;
      
      final allGroups = loadMore ? [...currentGroups, ...newGroups] : newGroups;
      
      if (!isClosed) {
        emit(GroupsSuccess(
          getGroups: allGroups,
          hasNext: result.pagination.hasNext,
          currentPage: result.pagination.page,
          isLoadMore: false,
        ));
      }
    } catch (e) {
      if (!isClosed) emit(GroupsError(message: e.toString()));
    }
  }

  Future<void> getDiscoverGroups({bool loadMore = false, int limit = 10}) async {
    await _fetchGroups(tab: 'discover', loadMore: loadMore, limit: limit);
  }

  Future<void> getJoinedGroups({bool loadMore = false, int limit = 10}) async {
    await _fetchGroups(tab: 'joined', loadMore: loadMore, limit: limit);
  }

  Future<void> getCreatedGroups({bool loadMore = false, int limit = 10}) async {
    await _fetchGroups(tab: 'created', loadMore: loadMore, limit: limit);
  }

  Future<void> getUnifiedChatList() async {
    if (isClosed) return;
    emit(GroupsLoading());
    try {
      final chatList = await getUnifiedChatListUseCase();
      if (!isClosed) emit(GroupsSuccess(getGroups: chatList));
    } catch (e) {
      if (!isClosed) emit(GroupsError(message: e.toString()));
    }
  }

  void markAsRead(String id, {required bool isGroup}) {
    if (state is GroupsSuccess) {
      final currentState = state as GroupsSuccess;
      final currentGroups = currentState.getGroups ?? [];
      
      final updatedGroups = currentGroups.map((group) {
        if (group.id == id) {
          return group.copyWith(unreadCount: 0);
        }
        return group;
      }).toList();

      emit(currentState.copyWith(
        getGroups: updatedGroups,
      ));

      markAsReadUseCase(id: id, isGroup: isGroup).catchError((_) {});
    }
  }
}
