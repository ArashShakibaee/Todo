// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_again/cubit/cubit.dart';
import 'package:todo_again/model/model.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  late final StreamSubscription todoListSubs;
  final TodoListCubit todoListCubit;
  ActiveTodoCountCubit({
    required this.todoListCubit,
  }) : super(ActiveTodoCountState.initial()) {
    todoListSubs = todoListCubit.stream.listen((TodoListState todoState) {
      final newActiveTodoCount = todoState.todos
          .where((Todo todo) => !todo.isCompleted)
          .toList()
          .length;

      emit(state.copyWith(activeTodoCount: newActiveTodoCount));
    });
  }
  @override
  Future<void> close() {
    todoListSubs.cancel();
    return super.close();
  }
}
