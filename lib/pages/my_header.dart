import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_again/bloc/active_todo_count/active_todo_count_bloc.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 8, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Todo",
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          Text(
            "${context.watch<ActiveTodoCountBloc>().state.activeTodoCount} items left",
            style: const TextStyle(color: Colors.red, fontSize: 20),
          )
        ],
      ),
    );
  }
}
