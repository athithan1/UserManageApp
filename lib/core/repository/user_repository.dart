import '../../features/user/model/user_model.dart';


class UserRepository {
  final List<UserModel> _users = [];

  List<UserModel> getAllUsers() {
    return List.unmodifiable(_users); 
  }

  void addUser(UserModel user) {
    _users.add(user);
  }

  void updateUser(UserModel updatedUser) {
    final index = _users.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      _users[index] = updatedUser.copyWith(
        name: updatedUser.name,
        email: updatedUser.email, 
        age: updatedUser.age,
      );
    }
  }

  void deleteUser(String id) {
    _users.removeWhere((user) => user.id == id);
  }
}
