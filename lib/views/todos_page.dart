import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justdoit/repos/auth_repo.dart';
import 'package:justdoit/services/gest/gest_bloc.dart';
import 'package:justdoit/services/gest/gest_event.dart';
import 'package:justdoit/services/gest/gest_state.dart';
import 'package:justdoit/utils/const.dart';
import 'package:justdoit/widgets/avatar/avatar.dart';
import 'package:justdoit/widgets/todos/todos_empty.dart';
import 'package:justdoit/widgets/todos/todo_tile.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  void onProfilePictureTap(GestState gestState) {}

  void onNotificationsTap() {}

  void onTaskAdd() {}

  Future<void> onRefresh(BuildContext context, GestState gestState) async {}

  @override
  Widget build(BuildContext context) {
    // Get the size of the phone
    final size = MediaQuery.of(context).size;
    final listViewHeight = size.height - 56 - 3 * 15 - 125;

    return BlocBuilder<GestBloc, GestState>(
      builder: (context, gestState) {
        return Scaffold(
          backgroundColor: AppColors.darkBlue,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,

            // title
            title: Text("${gestState.user!.name.toLowerCase()}'s list"),
            centerTitle: true,

            // the profile picture
            leading: Avatar(
              onTap: () => onProfilePictureTap(gestState),
              backgroundColor: AppColors.profilePicColor[1],
              child: Text(
                gestState.user != null
                    ? Utils.parseName(gestState.user!.name, 3)
                    : '',
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: AppResources.defaultFont,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              // the notifications
              Avatar(
                onTap: onNotificationsTap,
                backgroundColor: AppColors.profilePicColor[1],
                child: const Icon(Ionicons.notifications_outline),
              ),
            ],
          ),

          // the add task button
          floatingActionButton: Avatar(
            onTap: onTaskAdd,
            backgroundColor: AppColors.profilePicColor[1],
            child: const Icon(Ionicons.add_outline),
          ),

          // the body of the application
          body: gestState.todos.isEmpty
              ? const EmptyTodoListPage()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        // Separator between the appbar and the textbox
                        Divider(
                          color: AppColors.profilePicColor[0],
                        ),

                        // The research task textbox
                        SearchBox(),

                        // Separate the textbox from the todos
                        const SizedBox(height: 25.0),

                        // Display the todos
                        SizedBox(
                          height: listViewHeight,
                          child: RefreshIndicator(
                            onRefresh: () async => onRefresh,
                            child: ListView.builder(
                              itemCount: gestState.todos.length,
                              itemBuilder: (context, index) {
                                gestState.todos[index].assignedUsers!
                                    .add(gestState.todos[index].creator);

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: TodoTile(
                                    task: gestState.todos[index],
                                    creator: gestState.user!,
                                    assignedUsers: AuthRepo().getUserFromId(
                                      gestState.todos[index].assignedUsers!,
                                      gestState.users,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Separate the textbox from the todos
                        const SizedBox(height: 15.0),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class SearchBox extends StatelessWidget {
  // Creates the editing controller for searchbox
  final TextEditingController _tecSearchBox = TextEditingController();

  SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            style: TextStyle(
              fontFamily: AppResources.defaultFont,
              color: AppColors.black,
            ),
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: AppResources.taskSearchHint,
                hintStyle: TextStyle(
                  color: AppColors.lightGray,
                ),
                prefixIcon: Icon(Ionicons.search_outline)),
            onChanged: (value) => context.read<GestBloc>().add(
                  SearchTextChanged(
                    searchText: value,
                    context: context,
                  ),
                ),
            controller: _tecSearchBox,
          ),
        ),
      ),
    );
  }
}
