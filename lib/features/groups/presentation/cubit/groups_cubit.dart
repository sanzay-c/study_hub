import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/domain/usecase/get_all_groups_usecase.dart';
import 'package:study_hub/features/groups/domain/usecase/get_groups_usecase.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_state.dart';

@injectable
class GroupsCubit extends Cubit<GroupsState> {
  final GetGroupsUseCase getGroupsUseCase;
  final GetAllGroupsUsecase getAllGroupsUsecase;

  GroupsCubit({
    required this.getGroupsUseCase,
    required this.getAllGroupsUsecase,
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
      if (!isClosed) emit(GroupsSuccess(getGroups: groups));
    } catch (e) {
      if (!isClosed) emit(GroupsError(message: e.toString()));
    }
  }
}
