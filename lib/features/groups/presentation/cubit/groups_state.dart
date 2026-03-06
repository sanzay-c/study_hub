import 'package:equatable/equatable.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart';


import 'package:study_hub/features/groups/domain/entities/groups_entity.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();

  @override
  List<Object?> get props => [];
}

class GroupsInitial extends GroupsState {}

class GroupsLoading extends GroupsState {}

class GroupsSuccess extends GroupsState {
  final List<GroupsEntity>? groups;
  final List<GetGroupsEntity>? getGroups;

  const GroupsSuccess({this.groups, this.getGroups});

  @override
  List<Object?> get props => [groups, getGroups];
}

class GroupsError extends GroupsState {
  final String message;

  const GroupsError({required this.message});

  @override
  List<Object> get props => [message];
}
