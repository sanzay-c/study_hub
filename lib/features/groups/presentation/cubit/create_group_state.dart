import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupState extends Equatable {
  final String name;
  final String description;
  final XFile? image;
  final bool isPublic;
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const CreateGroupState({
    this.name = '',
    this.description = '',
    this.image,
    this.isPublic = true,
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  CreateGroupState copyWith({
    String? name,
    String? description,
    XFile? image,
    bool? isPublic,
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return CreateGroupState(
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      isPublic: isPublic ?? this.isPublic,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [name, description, isPublic, isLoading, error, isSuccess];
}