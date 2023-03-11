import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:justdoit/models/task.dart';
import 'package:justdoit/models/user.dart';
import 'package:justdoit/utils/const.dart';
import 'package:justdoit/widgets/avatar/avatar_group.dart';

class TodoTile extends StatelessWidget {
  final Task task;
  final User creator;
  final List<User> assignedUsers;

  const TodoTile({
    super.key,
    required this.task,
    required this.creator,
    required this.assignedUsers,
  });

  void onTaskPressed() {}

  void onTaskModify(BuildContext context) {
    print("lmao");
  }

  void onTaskDelete(BuildContext context) {
    print("bruh");
  }

  List<String> getNameOfUsers(List<User> users) {
    List<String> res = List.empty(growable: true);

    for (var user in users) {
      res.add(user.name);
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    List<String> users = getNameOfUsers(assignedUsers);
    users.add(creator.name);

    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15.0),
              onPressed: (context) => onTaskModify(context),
              icon: Ionicons.pencil_outline,
              backgroundColor: AppColors.profilePicColor[1],
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15.0),
              onPressed: (context) => onTaskDelete(context),
              icon: Ionicons.trash_bin_outline,
              backgroundColor: AppColors.red,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.name,
                    style: TextStyle(
                      fontFamily: AppResources.defaultFont,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Ionicons.calendar_number_outline),
                      if (task.endDate != null)
                        Text(
                          "${task.endDate!.day}/${task.endDate!.month}/${task.endDate!.year}",
                        ),
                    ],
                  ),
                  AvatarGroup(
                    inputArray: users,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
