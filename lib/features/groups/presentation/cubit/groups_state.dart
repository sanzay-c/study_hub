part of 'groups_cubit.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();

  @override
  List<Object> get props => [];
}

class GroupsInitial extends GroupsState {}

class GroupsLoading extends GroupsState {}

class GroupsSuccess extends GroupsState {
  final List<GroupsEntity> groups;

  const GroupsSuccess({required this.groups});

  @override
  List<Object> get props => [groups];
}

class GroupsError extends GroupsState {
  final String message;

  const GroupsError({required this.message});

  @override
  List<Object> get props => [message];
}
