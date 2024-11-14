import 'package:blog_app/core/common/entities/user.dart';

class UserModels extends User {
  UserModels({
    required super.email,
    required super.id,
    required super.name,
  });

  factory UserModels.fromJson(Map<String, dynamic> map) {
    return UserModels(
      email: map['email']??'',
      id: map['id']??'',
      name: map['name']??'',
    );
  }
}
