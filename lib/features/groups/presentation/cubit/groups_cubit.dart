import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/domain/entities/groups_entity.dart';
import 'package:study_hub/features/groups/domain/usecase/get_groups_usecase.dart';

part 'groups_state.dart';

@injectable
class GroupsCubit extends Cubit<GroupsState> {
  final GetGroupsUseCase getGroupsUseCase;

  GroupsCubit({required this.getGroupsUseCase}) : super(GroupsInitial());

  Future<void> getGroups() async {
    emit(GroupsLoading());
    try {
      final groups = await getGroupsUseCase();
      emit(GroupsSuccess(groups: groups));
    } catch (e) {
      emit(GroupsError(message: e.toString()));
    }
  }
}
