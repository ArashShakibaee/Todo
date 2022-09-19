import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_again/bloc/todo_list/todo_list_bloc.dart';
import 'package:todo_again/model/model.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  late final StreamSubscription todoListSubs;
  final TodoListBloc todoListBloc;
  ActiveTodoCountBloc({required this.todoListBloc})
      : super(ActiveTodoCountState.initial()) {
    todoListSubs = todoListBloc.stream.listen((TodoListState todoListState) {
      final int activeCount = todoListState.todos
          .where((Todo todo) => !todo.isCompleted)
          .toList()
          .length;
      add(ChangeActiveTodoCountEvent(activeCount: activeCount));
    });
    on<ChangeActiveTodoCountEvent>((event, emit) {
      emit(state.copyWith(activeTodoCount: event.activeCount));
    });
  }
  @override
  Future<void> close() {
    todoListSubs.cancel();
    return super.close();
  }
}
