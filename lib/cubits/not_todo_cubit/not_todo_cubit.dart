import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:not_todo/models/models.dart';
import 'package:not_todo/services/services.dart';

part 'not_todo_state.dart';

class NotTodoCubit extends Cubit<NotTodoState> {
  NotTodoCubit()
      : _databaseService = DatabaseService(),
        super(NotTodoState());

  final DatabaseService _databaseService;

  Future<void> insertNotTodo(NotTodo notTodo) async {
    await _databaseService.insertNotTodo(notTodo);
    await getDayNotTodos();
  }

  Future<void> updateNotTodo(NotTodo notTodo) async {
    await _databaseService.updateNotTodo(notTodo);
    await getDayNotTodos();
  }

  Future<void> deleteNotTodo(NotTodo notTodo) async {
    await _databaseService.deleteNotTodo(notTodo);
    await getDayNotTodos();
  }

  Future<void> deleteAll() async {
    await _databaseService.deleteAll();
    await getDayNotTodos();
  }

  Future<void> onChangedCompleted(NotTodo notTodo, bool value) async {
    NotTodo changedNotTodo = notTodo.copyWith(completed: value);
    await _databaseService.updateNotTodo(changedNotTodo);
    await getDayNotTodos(notTodo.date, false);
  }

  Future<void> getDayNotTodos([
    DateTime? dateTime,
    bool showLoading = true,
  ]) async {
    if (showLoading) emit(state.copyWith(status: NotTodoStatus.loading));
    DateTime selectedDate = dateTime ?? DateTime.now();
    String day = DateFormat('yyyy-MM-dd').format(selectedDate);
    List<NotTodo> notTodos = await _databaseService.getDayNotTodos(day);
    emit(state.copyWith(
      notTodos: notTodos,
      selectedDate: selectedDate,
      status: NotTodoStatus.success,
    ));
  }
}
