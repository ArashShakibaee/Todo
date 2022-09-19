import 'package:flutter/material.dart';
import 'package:todo_again/pages/create_todo.dart';
import 'package:todo_again/pages/my_header.dart';
import 'package:todo_again/pages/search_and_filter.dart';
import 'package:todo_again/pages/show_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            MyHeader(),
            CreateTodo(),
            SearchAndFilterTodo(),
            Expanded(child: ListTodos())
          ],
        ),
      ),
    );
  }
}
