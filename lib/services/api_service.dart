import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:job_preparation/models/user_model.dart';
//
// class ApiService {
//   static Future<List<UserDataModel>> fetchUsers() async {
//     final response = await http.get(Uri.parse('https://dummyjson.com/users'));
//
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body)['data'];
//       return data.map((mapdata) => UserDataModel.fromJson(mapdata)).toList();
//     } else {
//       throw Exception('Fail to load user ');
//     }
//   }
// }

import 'package:http/http.dart' as http;

import 'package:job_preparation/models/user_model.dart';

// class ApiService {
//   static Future<List<Users>> fetchUsers() async {
//     final response = await http.get(Uri.parse('https://dummyjson.com/users'));
//
//     if (response.statusCode == 200) {
//       // Parse the full response into UserDataModel
//       final userDataModel = UserDataModel.fromJson(json.decode(response.body));
//
//       // Return just the users list
//       return userDataModel.users ?? [];
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }
// }

class ApiService {
  Future<UserDataModel> fetchUserData() async {
    ///The method returns a Future that will eventually complete with a UserDataModel object
    final response = await http.get(Uri.parse('https://dummyjson.com/users'));

    if (response.statusCode == 200) {
      final userDataModel = UserDataModel.fromJson(json.decode(response.body));
      print('Totla users :${userDataModel.total}');
      return userDataModel;
    } else {
      throw Exception('Failed to load user data');
    }
  }
}