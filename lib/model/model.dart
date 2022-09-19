// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum Filter { all, active, completed }

Uuid uuid = const Uuid();

class Todo extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;
  Todo({
    String? id,
    required this.title,
    this.isCompleted = false,
  }) : id = uuid.v4();

  @override
  String toString() =>
      'Todo(id: $id, title: $title, isCompleted: $isCompleted)';

  @override
  List<Object?> get props => [id, title, isCompleted];
}
