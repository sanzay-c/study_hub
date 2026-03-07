import 'package:equatable/equatable.dart';

class CreateNewGroupEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final dynamic subject;
  final String createdBy;
  final List<String> members;
  final bool isPublic;
  final String imagePath;
  final DateTime createdAt;
  final String creatorName;
  final String imageUrl;

  const CreateNewGroupEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.subject,
    required this.createdBy,
    required this.members,
    required this.isPublic,
    required this.imagePath,
    required this.createdAt,
    required this.creatorName,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        subject,
        createdBy,
        members,
        isPublic,
        imagePath,
        createdAt,
        creatorName,
        imageUrl,
      ];
}