// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class CreateTodoEvent extends TodoListEvent {
  final String newTitle;
  const CreateTodoEvent({
    required this.newTitle,
  });

  @override
  String toString() => 'CreateTodoEvent(newTitle: $newTitle)';
  @override
  List<Object> get props => [newTitle];
}

class EditTodoEvent extends TodoListEvent {
  final String id;
  final String newTitle;
  const EditTodoEvent({
    required this.id,
    required this.newTitle,
  });
  @override
  List<Object> get props => [id, newTitle];

  @override
  String toString() => 'EditTodoEvent(id: $id, newTitle: $newTitle)';
}

class ToggleTodoEvent extends TodoListEvent {
  final String id;
  const ToggleTodoEvent({
    required this.id,
  });
  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ToggleTodoEvent(id: $id)';
}

class DeleteTodoEvent extends TodoListEvent {
  final Todo todo;
  const DeleteTodoEvent({
    required this.todo,
  });
  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'DeleteTodoEvent(todo: $todo)';
}
