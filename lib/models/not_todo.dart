import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NotTodo extends Equatable {
  NotTodo({
    String? id,
    this.task,
    this.completed = false,
    DateTime? date,
  })  : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now();

  final String id;
  final String? task;
  final bool completed;
  final DateTime date;

  NotTodo copyWith({
    String? id,
    String? task,
    bool? completed,
    DateTime? date,
  }) {
    return NotTodo(
      id: id ?? this.id,
      task: task ?? this.task,
      completed: completed ?? this.completed,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'completed': completed == true ? 1 : 0,
      'date': DateFormat('yyyy-MM-dd').format(date),
    };
  }

  static NotTodo fromMap(Map<String, dynamic> map) {
    return NotTodo(
      id: map['id'],
      task: map['task'],
      completed: map['completed'] == 1,
      date: DateTime.parse(map['date']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        task,
        completed,
        date,
      ];
}
