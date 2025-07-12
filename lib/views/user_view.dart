import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:job_preparation/controllers/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserView extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  UserView({super.key});
  Future<void> saveUsersToPrefs(List<dynamic> users) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(users.map((user) => user.toJson()).toList());
    await prefs.setString('saved_users', encoded);
    Get.snackbar('Saved', 'Users saved to SharedPreferences',
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> resetUsersFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_users');
    Get.snackbar('Reset', 'Saved users clear ',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    final users = userController.userData.value.users;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users with GetX and MVVM'),
        actions: [
          IconButton(
              onPressed: () {
                final users = userController.userData.value.users;
                final filteredUsers = users
                    ?.where((u) =>
                        u.firstName != null &&
                        u.firstName!.toLowerCase().startsWith('b'))
                    .take(5)
                    .toList();
                if (filteredUsers != null && filteredUsers.isNotEmpty) {
                  saveUsersToPrefs(filteredUsers);
                }
              },
              icon: Icon(Icons.save)),
          IconButton(
              onPressed: () {
                resetUsersFromPrefs();
              },
              icon: Icon(Icons.restore)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 500,
              child: Obx(() {
                if (userController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final users = userController.userData.value.users;

                if (users == null || users.isEmpty) {
                  return const Center(child: Text('No users found.'));
                }

                // /// filter users whose first name start with a  take 3 name
                final filterUsers = users
                    .where((users) =>
                        users.firstName != null &&
                        users.firstName!.toLowerCase().startsWith('a'))
                    .take(25)
                    .toList();
                if (filterUsers.isEmpty) {
                  return const Center(
                    child: Text('No user starting with a '),
                  );
                }
                return ListView.builder(
                  itemCount: filterUsers.length,

                  // itemCount: 5,
                  itemBuilder: (context, index) {
                    final user = filterUsers[index];
                    // if (saveUsersToPrefs)
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: user.image != null
                              ? NetworkImage(user.image!)
                              : null,
                          child: user.image == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        title: Text(user.firstName ?? 'No name'),
                        subtitle: Text(user.lastName ?? ''),
                      ),
                    );
                  },
                );
              }),
            ),
            // 👇 This is your new Text widget below the list
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(58.0),
                  child: Image.network(
                      'https://images.pexels.com/photos/31184177/pexels-photo-31184177.jpeg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(58.0),
                  child: _buildTextField('Message', maxLines: 3),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white24,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
////----old code
// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'package:job_preparation/controllers/user_controller.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserView extends StatelessWidget {
//   final UserController userController = Get.put(UserController());
//
//   UserView({super.key});
//   Future<void> saveUsersToPrefs(List<dynamic> users) async {
//     final prefs = await SharedPreferences.getInstance();
//     final encoded = jsonEncode(users.map((user) => user.toJson()).toList());
//     await prefs.setString('saved_users', encoded);
//     Get.snackbar('Saved', 'Users saved to SharedPreferences',
//         snackPosition: SnackPosition.BOTTOM);
//   }
//
//   Future<void> resetUsersFromPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('saved_users');
//     Get.snackbar('Reset', 'Saved users clear ',
//         snackPosition: SnackPosition.BOTTOM);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final users = userController.userData.value.users;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Users with GetX and MVVM'),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 final users = userController.userData.value.users;
//                 final filteredUsers = users
//                     ?.where((u) =>
//                         u.firstName != null &&
//                         u.firstName!.toLowerCase().startsWith('b'))
//                     .take(5)
//                     .toList();
//                 if (filteredUsers != null && filteredUsers.isNotEmpty) {
//                   saveUsersToPrefs(filteredUsers);
//                 }
//               },
//               icon: Icon(Icons.save)),
//           IconButton(
//               onPressed: () {
//                 resetUsersFromPrefs();
//               },
//               icon: Icon(Icons.restore)),
//         ],
//       ),
//       body: Obx(() {
//         if (userController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final users = userController.userData.value.users;
//
//         if (users == null || users.isEmpty) {
//           return const Center(child: Text('No users found.'));
//         }
//
//         // /// filter users whose first name start with a  take 3 name
//         final filterUsers = users
//             .where((users) =>
//                 users.firstName != null &&
//                 users.firstName!.toLowerCase().startsWith('a'))
//             .take(25)
//             .toList();
//         if (filterUsers.isEmpty) {
//           return const Center(
//             child: Text('No user starting with a '),
//           );
//         }
//         return ListView.builder(
//           itemCount: filterUsers.length,
//
//           // itemCount: 5,
//           itemBuilder: (context, index) {
//             final user = filterUsers[index];
//             // if (saveUsersToPrefs)
//             return Card(
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage:
//                       user.image != null ? NetworkImage(user.image!) : null,
//                   child: user.image == null ? const Icon(Icons.person) : null,
//                 ),
//                 title: Text(user.firstName ?? 'No name'),
//                 subtitle: Text(user.lastName ?? ''),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }