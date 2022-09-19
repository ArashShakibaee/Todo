import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_again/bloc/active_todo_count/active_todo_count_bloc.dart';
import 'package:todo_again/bloc/filtered_todos/filtered_todos_bloc.dart';
import 'package:todo_again/bloc/todo_filter/todo_filter_bloc.dart';
import 'package:todo_again/bloc/todo_list/todo_list_bloc.dart';
import 'package:todo_again/bloc/todo_search/todo_search_bloc.dart';
import 'package:todo_again/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => TodoFilterBloc())),
        BlocProvider(create: (context) => TodoListBloc()),
        BlocProvider(create: (context) => TodoSearchBloc()),
        BlocProvider(
            create: (context) => ActiveTodoCountBloc(
                todoListBloc: context.read<TodoListBloc>())),
        BlocProvider(
            create: (context) => FilteredTodosBloc(
                todoFilterBloc: context.read<TodoFilterBloc>(),
                todoListBloc: context.read<TodoListBloc>(),
                todoSearchBloc: context.read<TodoSearchBloc>()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}
