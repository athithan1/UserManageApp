import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/user_model.dart';
import '../provider/user_provider.dart';

class UserFormPage extends ConsumerStatefulWidget {
  final UserModel? existingUser;
  const UserFormPage({Key? key, this.existingUser}) : super(key: key);

  @override
  _UserFormPageState createState() => _UserFormPageState();
}

class _UserFormPageState extends ConsumerState<UserFormPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingUser != null) {
      _nameController.text = widget.existingUser!.name;
      _emailController.text = widget.existingUser!.email;
      _ageController.text = widget.existingUser!.age.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final email = _emailController.text;
                final age = int.tryParse(_ageController.text) ?? 0;

                if (name.isNotEmpty && email.isNotEmpty && age > 0) {
                  final userProvider = ref.read(userListProvider.notifier);

                  if (widget.existingUser == null) {
                    userProvider.createUser(
                      UserModel.create(name: name, email: email, age: age),
                    );
                  } else {
                    userProvider.updateUser(
                      UserModel(
                        id: widget.existingUser!.id,
                        name: name,
                        email: email,
                        age: age,
                      ),
                    );
                  }

                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
