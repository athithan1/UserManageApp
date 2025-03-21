import 'package:uuid/uuid.dart';

const _uuid = Uuid(); // 🔥 Generates unique IDs

class UserModel {
  final String id;
  final String name;
  final String email;
  final int age;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
  });

  // 🔥 Create User with Auto-Generated ID
  factory UserModel.create({required String name, required String email, required int age}) {
    return UserModel(id: _uuid.v4(), name: name, email: email, age: age);
  }

  // 🔥 CopyWith Method for Updating Users
  UserModel copyWith({String? name, String? email, int? age}) {
    return UserModel(
      id: id, // ID should not change
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
    );
  }
}
