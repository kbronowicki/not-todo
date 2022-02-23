import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:not_todo/cubits/cubits.dart';
import 'package:not_todo/generated/l10n.dart';
import 'package:not_todo/models/models.dart';

class AddEditBottomSheet extends StatefulWidget {
  const AddEditBottomSheet({
    Key? key,
    this.notTodo,
  }) : super(key: key);

  final NotTodo? notTodo;

  @override
  _AddEditBottomSheetState createState() => _AddEditBottomSheetState();
}

class _AddEditBottomSheetState extends State<AddEditBottomSheet> {
  late NotTodo _notTodo;
  bool _showEmptyError = false;

  @override
  void initState() {
    if (widget.notTodo == null) {
      _notTodo = NotTodo();
    } else {
      _notTodo = widget.notTodo!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.notTodo == null
                  ? S.of(context).createNewNotTodo
                  : S.of(context).updateExistingNotTodo,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).task,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: _notTodo.task,
              onChanged: (value) {
                setState(() {
                  _notTodo = _notTodo.copyWith(task: value.trim());
                });
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(CupertinoIcons.doc_plaintext),
              ),
            ),
            Visibility(
              visible: _showEmptyError,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  S.of(context).taskEmpty,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).date,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () async {
                DateTime? _selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 60)),
                );
                setState(() {
                  _notTodo = _notTodo.copyWith(date: _selectedDate);
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(CupertinoIcons.calendar_today),
                  Text(
                    DateFormat.yMMMMEEEEd().format(_notTodo.date),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                if (widget.notTodo != null) ...[
                  Flexible(
                    flex: 2,
                    child: TextButton.icon(
                      icon: const Icon(CupertinoIcons.trash),
                      label: Text(S.of(context).delete),
                      onPressed: () {
                        context.read<NotTodoCubit>().deleteNotTodo(_notTodo);
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                          primary: Theme.of(context).colorScheme.error),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Flexible(
                  flex: 3,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_notTodo.task == null || _notTodo.task!.isEmpty) {
                        setState(() {
                          _showEmptyError = true;
                        });
                        return;
                      }
                      if (widget.notTodo == null) {
                        context.read<NotTodoCubit>().insertNotTodo(_notTodo);
                      } else {
                        context.read<NotTodoCubit>().updateNotTodo(_notTodo);
                      }
                      Navigator.pop(context);
                    },
                    icon: const Icon(CupertinoIcons.checkmark_alt),
                    label: Text(
                      widget.notTodo == null
                          ? S.of(context).addNotTodo
                          : S.of(context).updateNotTodo,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
