import 'package:flutter/material.dart';
import 'package:todo_again/bloc/blocs.dart';
import 'package:todo_again/model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAndFilterTodo extends StatefulWidget {
  const SearchAndFilterTodo({super.key});

  @override
  State<SearchAndFilterTodo> createState() => _SearchAndFilterTodoState();
}

class _SearchAndFilterTodoState extends State<SearchAndFilterTodo> {
  late final TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          controller: textEditingController,
          onChanged: (String? value) {
            if (value != null) {
              context
                  .read<TodoSearchBloc>()
                  .add(ChangeSearchTerm(newSearchTerm: value));
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade300,
            hintText: "Search Todos",
            prefixIcon: const Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _filterButton(context, Filter.all),
            _filterButton(context, Filter.active),
            _filterButton(context, Filter.completed),
          ],
        ),
      ],
    );
  }

  Widget _filterButton(BuildContext context, Filter filter) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: (() {
              context
                  .read<TodoFilterBloc>()
                  .add(ChangeTodoFilterEvent(filter: filter));
            }),
            child: Text(
              filter == Filter.all
                  ? "ALL"
                  : filter == Filter.active
                      ? "Active"
                      : "Completed",
              style: TextStyle(fontSize: 17, color: _color(context, filter)),
            ),
          ),
          const SizedBox(height: 5),
          Divider(
            color: _color(context, filter),
            thickness: 2,
          ),
        ],
      ),
    );
  }

  Color _color(BuildContext context, Filter filter) {
    late final currentState = context.watch<TodoFilterBloc>().state.filter;
    return currentState == filter ? Colors.blue : Colors.grey;
  }
}
