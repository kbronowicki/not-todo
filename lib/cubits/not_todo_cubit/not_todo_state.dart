part of 'not_todo_cubit.dart';

enum NotTodoStatus { loading, success }

class NotTodoState extends Equatable {
  NotTodoState({
    this.notTodos = const [],
    DateTime? selectedDate,
    this.status = NotTodoStatus.loading,
  }) : selectedDate = selectedDate ?? DateTime.now();

  final List<NotTodo> notTodos;
  final DateTime selectedDate;
  final NotTodoStatus status;

  NotTodoState copyWith({
    List<NotTodo>? notTodos,
    DateTime? selectedDate,
    NotTodoStatus? status,
  }) {
    return NotTodoState(
      notTodos: notTodos ?? this.notTodos,
      selectedDate: selectedDate ?? this.selectedDate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        notTodos,
        selectedDate,
        status,
      ];
}
