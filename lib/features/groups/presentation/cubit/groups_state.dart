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
  final bool hasNext;
  final int currentPage;
  final bool isLoadMore;

  const GroupsSuccess({
    this.groups,
    this.getGroups,
    this.hasNext = false,
    this.currentPage = 1,
    this.isLoadMore = false,
  });

  GroupsSuccess copyWith({
    List<GroupsEntity>? groups,
    List<GetGroupsEntity>? getGroups,
    bool? hasNext,
    int? currentPage,
    bool? isLoadMore,
  }) {
    return GroupsSuccess(
      groups: groups ?? this.groups,
      getGroups: getGroups ?? this.getGroups,
      hasNext: hasNext ?? this.hasNext,
      currentPage: currentPage ?? this.currentPage,
      isLoadMore: isLoadMore ?? this.isLoadMore,
    );
  }

  @override
  List<Object?> get props => [groups, getGroups, hasNext, currentPage, isLoadMore];
}

class GroupsError extends GroupsState {
  final String message;

  const GroupsError({required this.message});

  @override
  List<Object> get props => [message];
}
