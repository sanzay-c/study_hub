import 'package:equatable/equatable.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_detail_entity.dart';

abstract class GroupDetailState extends Equatable {
  const GroupDetailState();

  @override
  List<Object?> get props => [];
}

class GroupDetailInitial extends GroupDetailState {}

class GroupDetailLoading extends GroupDetailState {}

class GroupDetailSuccess extends GroupDetailState {
  final GetGroupsDetailEntity groupDetail;
  final String groupId;

  const GroupDetailSuccess({required this.groupDetail, required this.groupId});

  @override
  List<Object?> get props => [groupDetail, groupId];
}

class GroupDetailError extends GroupDetailState {
  final String message;

  const GroupDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
