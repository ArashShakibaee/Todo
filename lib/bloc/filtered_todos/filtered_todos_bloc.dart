// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_again/bloc/todo_filter/todo_filter_bloc.dart';
import 'package:todo_again/bloc/todo_list/todo_list_bloc.dart';
import 'package:todo_again/bloc/todo_search/todo_search_bloc.dart';
import 'package:todo_again/model/model.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  late final StreamSubscription todoListSubs;
  late final StreamSubscription todoSearchSubs;
  late final StreamSubscription todoFilterSubs;
  final TodoListBloc todoListBloc;
  final TodoSearchBloc todoSearchBloc;
  final TodoFilterBloc todoFilterBloc;
  FilteredTodosBloc({
    required this.todoListBloc,
    required this.todoSearchBloc,
    required this.todoFilterBloc,
  }) : super(FilteredTodosState.initial()) {
    todoFilterSubs =
        todoFilterBloc.stream.listen((TodoFilterState filterState) {
      setChanges();
    });
    todoListSubs = todoListBloc.stream.listen((TodoListState listState) {
      setChanges();
    });
    todoSearchSubs =
        todoSearchBloc.stream.listen((TodoSearchState searchState) {
      setChanges();
    });
    on<ChangeFilteredTodoEvent>((event, emit) {
      emit(state.copyWith(filteredTodos: event.todos));
    });
  }
  void setChanges() {
    List<Todo> filterTodos;
    switch (todoFilterBloc.state.filter) {
      case Filter.active:
        filterTodos = todoListBloc.state.todos
            .where((Todo todo) => !todo.isCompleted)
            .toList();
        break;
      case Filter.completed:
        filterTodos = todoListBloc.state.todos
            .where((Todo todo) => todo.isCompleted)
            .toList();
        break;
      case Filter.all:
      default:
        filterTodos = todoListBloc.state.todos;
    }
    if (todoSearchBloc.state.searchTerm.isNotEmpty) {
      filterTodos = filterTodos
          .where((Todo todo) => todo.title
              .toLowerCase()
              .contains(todoSearchBloc.state.searchTerm))
          .toList();
    }
    add(ChangeFilteredTodoEvent(todos: filterTodos));
  }

  @override
  Future<void> close() {
    todoFilterSubs.cancel();
    todoListSubs.cancel();
    todoSearchSubs.cancel();
    return super.close();
  }
}
