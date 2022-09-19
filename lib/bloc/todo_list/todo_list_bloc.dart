import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_again/model/model.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<CreateTodoEvent>((event, emit) {
      final newTodo = Todo(title: event.newTitle);
      final newTodos = [...state.todos, newTodo];
      emit(state.copyWith(todos: newTodos));
    });
    on<EditTodoEvent>((event, emit) {
      final newTodos = state.todos.map((Todo todo) {
        if (todo.id == event.id) {
          return Todo(
              id: event.id,
              title: event.newTitle,
              isCompleted: todo.isCompleted);
        }
        return todo;
      }).toList();
      emit(state.copyWith(todos: newTodos));
    });
    on<ToggleTodoEvent>((event, emit) {
      final newTodos = state.todos.map((Todo todo) {
        if (todo.id == event.id) {
          return Todo(
              id: event.id, title: todo.title, isCompleted: !todo.isCompleted);
        }
        return todo;
      }).toList();
      emit(state.copyWith(todos: newTodos));
    });
    on<DeleteTodoEvent>((event, emit) {
      final newTodos =
          state.todos.where((Todo todo) => todo.id != event.todo.id).toList();
      emit(state.copyWith(todos: newTodos));
    });
  }
}
