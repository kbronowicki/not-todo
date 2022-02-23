import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:not_todo/cubits/cubits.dart';
import 'package:not_todo/generated/l10n.dart';
import 'package:not_todo/models/models.dart';
import 'package:not_todo/widgets/widgets.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotTodoCubit, NotTodoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).calendar),
          ),
          body: Column(
            children: [
              CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateChanged: (selectedDate) {
                  context.read<NotTodoCubit>().getDayNotTodos(selectedDate);
                },
              ),
              Text(DateFormat.yMMMMEEEEd().format(state.selectedDate)),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (state.status == NotTodoStatus.loading) {
                      return const LoadingIndicator();
                    }
                    if (state.notTodos.isEmpty) {
                      return Center(
                        child: Text(S.of(context).noTasks('day')),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.notTodos.length,
                      itemBuilder: (context, index) {
                        NotTodo notTodo = state.notTodos[index];
                        return NotTodoTile(notTodo: notTodo);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
