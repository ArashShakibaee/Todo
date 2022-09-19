import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_again/bloc/todo_list/todo_list_bloc.dart';
import 'package:todo_again/cubit/cubit.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
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
    return TextField(
      onSubmitted: (String? text) {
        if (text != null && text.trim().isNotEmpty) {
          context.read<TodoListBloc>().add(CreateTodoEvent(newTitle: text));
          textController.clear();
        }
      },
      controller: textController,
      decoration: const InputDecoration(
        hintText: "What to do ?",
      ),
    );
  }
}
