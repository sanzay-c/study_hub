import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/chat/domain/usecase/mark_as_read_usecase.dart';
import 'package:study_hub/features/groups/domain/usecase/get_all_groups_usecase.dart';
import 'package:study_hub/features/groups/domain/usecase/get_groups_usecase.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_state.dart';

@injectable
class GroupsCubit extends Cubit<GroupsState> {
  final GetGroupsUseCase getGroupsUseCase;
  final GetAllGroupsUsecase getAllGroupsUsecase;
  final MarkAsReadUseCase markAsReadUseCase;

  GroupsCubit({
    required this.getGroupsUseCase,
    required this.getAllGroupsUsecase,
    required this.markAsReadUseCase,
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

  Future<void> getDiscoverGroups() async {
    if (isClosed) return;
    emit(GroupsLoading());
    try {
      final groups = await getAllGroupsUsecase(tab: 'discover');
      groups.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      if (!isClosed) emit(GroupsSuccess(getGroups: groups));
    } catch (e) {
      if (!isClosed) emit(GroupsError(message: e.toString()));
    }
  }

  Future<void> getJoinedGroups() async {
    if (isClosed) return;
    emit(GroupsLoading());
    try {
      final groups = await getAllGroupsUsecase(tab: 'joined');
      groups.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      if (!isClosed) emit(GroupsSuccess(getGroups: groups));
    } catch (e) {
      if (!isClosed) emit(GroupsError(message: e.toString()));
    }
  }

  Future<void> getCreatedGroups() async {
    if (isClosed) return;
    emit(GroupsLoading());
    try {
      final groups = await getAllGroupsUsecase(tab: 'created');
      groups.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      if (!isClosed) emit(GroupsSuccess(getGroups: groups));
    } catch (e) {
      if (!isClosed) emit(GroupsError(message: e.toString()));
    }
  }

  void markAsRead(String groupId) {
    if (state is GroupsSuccess) {
      final currentState = state as GroupsSuccess;
      final currentGroups = currentState.getGroups ?? [];
      
      // 1. Optimistic UI update — instantly clear badge before server responds
      final updatedGroups = currentGroups.map((group) {
        if (group.id == groupId) {
          return group.copyWith(unreadCount: 0);
        }
        return group;
      }).toList();

      emit(GroupsSuccess(
        groups: currentState.groups,
        getGroups: updatedGroups,
      ));

      // 2. Background — notify backend silently (no loading state)
      markAsReadUseCase(id: groupId, isGroup: true).catchError((_) {
        // Silent fail: If backend call fails, the local state is already cleared.
        // The count will re-sync on next refresh.
      });
    }
  }
}
