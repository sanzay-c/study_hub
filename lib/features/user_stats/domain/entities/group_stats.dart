import 'package:equatable/equatable.dart';

class GroupStats extends Equatable {
  final int? total;
  final int? created;
  final int? joined;

  const GroupStats({
    this.total,
    this.created,
    this.joined,
  });

  @override
  List<Object?> get props => [total, created, joined];
}