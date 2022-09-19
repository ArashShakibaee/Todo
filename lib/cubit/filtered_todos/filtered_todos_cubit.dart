// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_again/cubit/cubit.dart';
import 'package:todo_again/model/model.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  late final StreamSubscription todoListSubscription;
  late final StreamSubscription todoFilterSubscription;
  late final StreamSubscription todoSearchSubscription;
  final TodoSearchCubit searchCubit;
  final TodoFilterCubit filterCubit;
  final TodoListCubit listCubit;
  FilteredTodosCubit({
    required this.searchCubit,
    required this.filterCubit,
    required this.listCubit,
  }) : super(FilteredTodosState.initial()) {
    void whatTodo() {
      List<Todo> filterTodos;
      switch (filterCubit.state.filter) {
        case Filter.active:
          filterTodos = listCubit.state.todos
              .where((Todo todo) => !todo.isCompleted)
              .toList();
          break;
        case Filter.completed:
          filterTodos = listCubit.state.todos
              .where((Todo todo) => todo.isCompleted)
              .toList();
          break;
        case Filter.all:
        default:
          filterTodos = listCubit.state.todos;
      }
      if (searchCubit.state.search.isNotEmpty) {
        filterTodos = filterTodos
            .where((Todo todo) =>
                todo.title.toLowerCase().contains(searchCubit.state.search))
            .toList();
        emit(state.copyWith(filteredTodos: filterTodos));
      }
      emit(state.copyWith(filteredTodos: filterTodos));
    }

    todoFilterSubscription =
        filterCubit.stream.listen((TodoFilterState filterState) {
      whatTodo();
    });
    todoSearchSubscription =
        searchCubit.stream.listen((TodoSearchState searchState) {
      whatTodo();
    });
    todoListSubscription = listCubit.stream.listen((TodoListState filterState) {
      whatTodo();
    });
  }
  @override
  Future<void> close() {
    todoFilterSubscription.cancel();
    todoListSubscription.cancel();
    todoSearchSubscription.cancel();
    return super.close();
  }
}
