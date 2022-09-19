import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_again/bloc/filtered_todos/filtered_todos_bloc.dart';
import 'package:todo_again/bloc/todo_filter/todo_filter_bloc.dart';
import 'package:todo_again/bloc/todo_list/todo_list_bloc.dart';
import 'package:todo_again/model/model.dart';

class ListTodos extends StatefulWidget {
  const ListTodos({super.key});

  @override
  State<ListTodos> createState() => _ListTodosState();
}

class _ListTodosState extends State<ListTodos> {
  late final TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosBloc>().state.filteredTodos;
    final filter = context.watch<TodoFilterBloc>().state.filter;
    return todos.isNotEmpty
        ? ListView.separated(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                background: _background(0),
                secondaryBackground: _background(1),
                onDismissed: (_) {
                  context
                      .read<TodoListBloc>()
                      .add(DeleteTodoEvent(todo: todos[index]));
                },
                confirmDismiss: (_) {
                  return showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Delete Alert !"),
                            content: const Text(
                                "Are you sure you wanna delete todo ?"),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text("NO")),
                              TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text("Yes")),
                            ],
                          ));
                },
                key: ValueKey(todos[index].id),
                child: ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          textController.text = todos[index].title;
                          return StatefulBuilder(
                              builder: ((context, setState) => AlertDialog(
                                    title: const Text("Edit Todo !"),
                                    content: TextField(
                                      autofocus: true,
                                      controller: textController,
                                      decoration: InputDecoration(
                                          hintText: "Change Todo name",
                                          errorText: textController.text.isEmpty
                                              ? "this field can not be empty"
                                              : null),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Cancel")),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              if (textController
                                                  .text.isNotEmpty) {
                                                context
                                                    .read<TodoListBloc>()
                                                    .add(EditTodoEvent(
                                                        id: todos[index].id,
                                                        newTitle: textController
                                                            .text));

                                                Navigator.pop(context);
                                              }
                                            });
                                          },
                                          child: const Text("Edit")),
                                    ],
                                  )));
                        });
                  },
                  leading: Checkbox(
                    value: todos[index].isCompleted,
                    onChanged: (_) {
                      context
                          .read<TodoListBloc>()
                          .add(ToggleTodoEvent(id: todos[index].id));
                    },
                  ),
                  title: Text(todos[index].title),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
            ),
          )
        : Center(
            child: Text(
                "No data to show for ${filter == Filter.all ? "All" : filter == Filter.active ? "Active" : "Complected"}"));
  }

  Widget _background(int alignment) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      alignment: alignment == 0 ? Alignment.centerLeft : Alignment.centerRight,
      color: Colors.red,
      child: const Icon(Icons.delete_rounded, size: 30, color: Colors.white),
    );
  }
}
