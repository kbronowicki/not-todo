import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_todo/cubits/cubits.dart';
import 'package:not_todo/models/models.dart';

class NotTodoTile extends StatelessWidget {
  const NotTodoTile({
    Key? key,
    required this.notTodo,
  }) : super(key: key);

  final NotTodo notTodo;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(notTodo.task!),
      value: notTodo.completed,
      onChanged: (value) =>
          context.read<NotTodoCubit>().onChangedCompleted(notTodo, value!),
    );
  }
}
