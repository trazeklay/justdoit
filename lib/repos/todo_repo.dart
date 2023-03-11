import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

import 'package:justdoit/models/task.dart';
import 'package:justdoit/models/user.dart';
import 'package:justdoit/utils/apiaccess.dart';
import 'package:justdoit/utils/const.dart';

class TodoRepo {
  final url = "http://192.168.0.8:3000/api/task";

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      List<dynamic> tasksJson = jsonDecode(response.body);
      List<Task> tasks =
          tasksJson.map((taskJson) => Task.fromMap(taskJson)).toList();
      return tasks;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception("Error, could not load tasks !");
    }
  }

  Future<List<Task>> getTasksOfUser(User user) async {
    final List<Task> tasks = await fetchTasks();
    final List<Task> res = List.empty(growable: true);

    for (var task in tasks) {
      if (task.creator == user.id ||
          (task.assignedUsers != null &&
              task.assignedUsers!.contains(user.id))) {
        res.add(task);
      }
    }

    return res;
  }

  Future<List<Task>> createTask(Task task) async {
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(task));

    if (response.statusCode == 201) {
      return await fetchTasks();
    } else {
      throw Exception("Unable to create the task");
    }
  }

  Future<List<Task>> updateTask(Task task) async {
    final taskUrl = "$url/${task.id}";
    final response = await http.put(
      Uri.parse(taskUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(task),
    );

    if (response.statusCode == 200) {
      final List<Task> res = await fetchTasks();
      return res;
    } else {
      throw Exception("Unable to modify the task");
    }
  }

  Future<List<Task>> deleteTask(String taskId) async {
    final taskUrl = "$url/$taskId";
    final response = await http.delete(Uri.parse(taskUrl));

    if (response.statusCode == 204) {
      final res = await fetchTasks();
      return res;
    } else {
      throw Exception("Unable to delete the task");
    }
  }

  Future<User> changeProfilePic(User user) async {
    final userUrl = "${ApiAccess.IP}/user/${user.id}";
    user.colorId = math.Random().nextInt(AppColors.profilePicColor.length);
    final response = await http.put(
      Uri.parse(userUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      return user;
    } else {
      throw Exception("Unable to change user profile pic !");
    }
  }
}
