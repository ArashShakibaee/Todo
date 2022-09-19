// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_todos_bloc.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();

  @override
  List<Object> get props => [];
}

class ChangeFilteredTodoEvent extends FilteredTodosEvent {
  final List<Todo> todos;
  const ChangeFilteredTodoEvent({
    required this.todos,
  });

  @override
  String toString() => 'ChangeFilteredTodoEvent(todos: $todos)';
  @override
  List<Object> get props => [todos];
}
