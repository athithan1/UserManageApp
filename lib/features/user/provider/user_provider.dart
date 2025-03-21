import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../user/model/user_model.dart'; 
import '../../../core/repository/user_repository.dart'; 

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});


/// Manages user list state using Riverpod's StateNotifier
final userListProvider = StateNotifierProvider<UserListNotifier, List<UserModel>>((ref) {
  final repository = ref.read(userRepositoryProvider); 
  return UserListNotifier(repository);
});

/// UserListNotifier handles CRUD operations
class UserListNotifier extends StateNotifier<List<UserModel>> {
  final UserRepository _repository;

  UserListNotifier(this._repository) : super(_repository.getAllUsers());

  void createUser(UserModel user) {
    _repository.addUser(user);
    _updateState(); 
  }

  void updateUser(UserModel updatedUser) {
    _repository.updateUser(updatedUser);
    _updateState();
  }

  void deleteUser(String id) {
    _repository.deleteUser(id);
    _updateState();
  }

  /// 🔥 Updates state efficiently
  void _updateState() {
    state = [..._repository.getAllUsers()]; 
  }
}
