import 'package:equatable/equatable.dart';
import 'package:study_hub/features/auth/domain/entities/user.dart';

sealed class UploadAvatarState extends Equatable {
  const UploadAvatarState();

  @override
  List<Object?> get props => [];
}

final class UploadAvatarInitial extends UploadAvatarState {}

final class UploadAvatarLoading extends UploadAvatarState {}

final class UploadAvatarSuccess extends UploadAvatarState {
  final User user;
  const UploadAvatarSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class UploadAvatarError extends UploadAvatarState {
  final String message;
  const UploadAvatarError(this.message);

  @override
  List<Object?> get props => [message];
}
