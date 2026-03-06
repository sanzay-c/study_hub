import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/domain/usecase/get_groups_detail_usecase.dart';
import 'group_detail_state.dart';

@injectable
class GroupDetailCubit extends Cubit<GroupDetailState> {
  final GetGroupDetailsUseCase getGroupDetailsUseCase;

  GroupDetailCubit({
    required this.getGroupDetailsUseCase,
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
}
