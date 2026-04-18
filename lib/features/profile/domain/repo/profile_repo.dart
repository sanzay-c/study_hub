import 'package:study_hub/features/auth/domain/entities/user.dart';

abstract class ProfileRepo {
  Future<User> updateFullName(String fullName);
}
