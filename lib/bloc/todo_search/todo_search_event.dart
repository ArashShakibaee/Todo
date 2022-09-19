// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_search_bloc.dart';

abstract class TodoSearchEvent extends Equatable {
  const TodoSearchEvent();

  @override
  List<Object> get props => [];
}

class ChangeSearchTerm extends TodoSearchEvent {
  final String newSearchTerm;
  const ChangeSearchTerm({
    required this.newSearchTerm,
  });

  @override
  String toString() => 'ChangeSearchTerm(newSearchTerm: $newSearchTerm)';

  @override
  List<Object> get props => [newSearchTerm];
}
