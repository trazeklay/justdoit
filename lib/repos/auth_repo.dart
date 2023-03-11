import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justdoit/models/user.dart';
import 'package:justdoit/services/encrypt.dart';
import 'package:justdoit/utils/apiaccess.dart';

class AuthRepo {
  Future<User?> login(String name, String password) async {
    final List<User> users = await fetchUsers();
    final sc = ServiceCrypto();

    for (var user in users) {
      if (user.name == name && user.password == sc.encrypt(password)) {
        return user;
      }
    }

    return null;
  }

  Future<List<User>> fetchUsers() async {
    const url = "${ApiAccess.IP}/user";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      List<dynamic> usersJson = jsonDecode(response.body);
      List<User> users =
          usersJson.map((userJson) => User.fromMap(userJson)).toList();
      return users;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load users');
    }
  }

  List<User> getUserFromId(List<String> ids, List<User>? users) {
    users = users ?? [];
    final List<User> res =
        users.where((user) => ids.contains(user.id)).toList();

    return res;
  }
}
