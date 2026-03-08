import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_detail_entity.dart';
import 'package:study_hub/features/groups/domain/usecase/delete_group_usecase.dart';
import 'package:study_hub/features/groups/domain/usecase/get_groups_detail_usecase.dart';
import 'package:study_hub/features/groups/domain/usecase/join_group_usecase.dart';
import 'package:study_hub/features/groups/domain/usecase/leave_group_usecase.dart';
import 'package:study_hub/features/groups/domain/usecase/remove_member_usecase.dart';
import 'group_detail_state.dart';

@injectable
class GroupDetailCubit extends Cubit<GroupDetailState> {
  final GetGroupDetailsUseCase getGroupDetailsUseCase;
  final JoinGroupUseCase joinGroupUseCase;
  final LeaveGroupUseCase leaveGroupUseCase;
  final DeleteGroupUseCase deleteGroupUseCase;
  final RemoveMemberUseCase removeMemberUseCase;

  GroupDetailCubit({
    required this.getGroupDetailsUseCase,
    required this.joinGroupUseCase,
    required this.leaveGroupUseCase,
    required this.deleteGroupUseCase,
    required this.removeMemberUseCase,
  }) : super(GroupDetailInitial());

  Future<void> getGroupDetails(String groupId) async {
    if (isClosed) return;
    emit(GroupDetailLoading());
    try {
      final detail = await getGroupDetailsUseCase(groupId);
      if (!isClosed) {
        emit(
          GroupDetailSuccess(
            groupDetail: detail,
            groupId: groupId,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) emit(GroupDetailError(message: e.toString()));
    }
  }

  Future<void> joinGroup(String groupId) async {
    if (isClosed) return;
    final currentState = state;
    GetGroupsDetailEntity? currentData;
    if (currentState is GroupDetailSuccess) {
      currentData = currentState.groupDetail;
    } else if (currentState is GroupDetailActionLoading) {
      currentData = currentState.groupDetail;
    }

    emit(GroupDetailActionLoading(groupDetail: currentData));
    try {
      await joinGroupUseCase(groupId);
      if (!isClosed) {
        emit(GroupDetailActionSuccess(message: "Joined group successfully", groupDetail: currentData));
        // Refresh details
        await getGroupDetails(groupId);
      }
    } catch (e) {
      if (!isClosed) {
        emit(GroupDetailActionError(message: e.toString(), groupDetail: currentData));
        // Re-emit success if we were in success state
        if (currentState is GroupDetailSuccess) {
          emit(currentState);
        }
      }
    }
  }

  Future<void> leaveGroup(String groupId) async {
    if (isClosed) return;
    final currentState = state;
    GetGroupsDetailEntity? currentData;
    if (currentState is GroupDetailSuccess) {
      currentData = currentState.groupDetail;
    } else if (currentState is GroupDetailActionLoading) {
      currentData = currentState.groupDetail;
    }

    emit(GroupDetailActionLoading(groupDetail: currentData));
    try {
      await leaveGroupUseCase(groupId);
      if (!isClosed) {
        emit(GroupDetailActionSuccess(message: "Left group successfully", groupDetail: currentData));
        await getGroupDetails(groupId);
      }
    } catch (e) {
      if (!isClosed) {
        emit(GroupDetailActionError(message: e.toString(), groupDetail: currentData));
        if (currentState is GroupDetailSuccess) {
          emit(currentState);
        }
      }
    }
  }

  Future<void> deleteGroup(String groupId) async {
    if (isClosed) return;
    final currentState = state;
    GetGroupsDetailEntity? currentData;
    if (currentState is GroupDetailSuccess) {
      currentData = currentState.groupDetail;
    } else if (currentState is GroupDetailActionLoading) {
      currentData = currentState.groupDetail;
    }

    emit(GroupDetailActionLoading(groupDetail: currentData));
    try {
      await deleteGroupUseCase(groupId);
      if (!isClosed) {
        emit(GroupDetailActionSuccess(message: "Group deleted successfully", groupDetail: currentData));
      }
    } catch (e) {
      if (!isClosed) {
        emit(GroupDetailActionError(message: e.toString(), groupDetail: currentData));
        if (currentState is GroupDetailSuccess) {
          emit(currentState);
        }
      }
    }
  }

  Future<void> removeMember(String groupId, String userId) async {
    if (isClosed) return;
    final currentState = state;
    GetGroupsDetailEntity? currentData;
    if (currentState is GroupDetailSuccess) {
      currentData = currentState.groupDetail;
    } else if (currentState is GroupDetailActionLoading) {
      currentData = currentState.groupDetail;
    }

    emit(GroupDetailActionLoading(groupDetail: currentData));
    try {
      await removeMemberUseCase(groupId, userId);
      if (!isClosed) {
        emit(GroupDetailActionSuccess(message: "Member removed successfully", groupDetail: currentData));
        await getGroupDetails(groupId);
      }
    } catch (e) {
      if (!isClosed) {
        emit(GroupDetailActionError(message: e.toString(), groupDetail: currentData));
        if (currentState is GroupDetailSuccess) {
          emit(currentState);
        }
      }
    }
  }
}
