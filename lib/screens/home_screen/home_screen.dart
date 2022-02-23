import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:not_todo/cubits/cubits.dart';
import 'package:not_todo/generated/l10n.dart';
import 'package:not_todo/models/models.dart';
import 'package:not_todo/screens/home_screen/screen_widgets/screen_widgets.dart';
import 'package:not_todo/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NotTodoCubit>().getDayNotTodos();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).notTodo),
      ),
      body: BlocBuilder<NotTodoCubit, NotTodoState>(
        builder: (context, state) {
          if (state.status == NotTodoStatus.loading) {
            return const LoadingIndicator();
          }
          if (state.notTodos.isEmpty) {
            return Center(
              child: Text(S.of(context).noTasks('today')),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  DateFormat.yMMMMEEEEd().format(state.selectedDate),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.notTodos.length,
                  itemBuilder: (context, index) {
                    NotTodo notTodo = state.notTodos[index];
                    return GestureDetector(
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) =>
                              AddEditBottomSheet(notTodo: notTodo),
                        );
                      },
                      child: NotTodoTile(notTodo: notTodo),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: const Icon(
          CupertinoIcons.add,
          size: 36,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const AddEditBottomSheet(),
          );
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
