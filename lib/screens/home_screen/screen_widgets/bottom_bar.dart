import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_todo/cubits/cubits.dart';
import 'package:not_todo/generated/l10n.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/calendarScreen').then(
              (value) => context.read<NotTodoCubit>().getDayNotTodos(),
            ),
            icon: const Icon(CupertinoIcons.calendar),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        S.of(context).settings,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      ListTile(
                        iconColor: Theme.of(context).colorScheme.error,
                        textColor: Theme.of(context).colorScheme.error,
                        leading: const Icon(CupertinoIcons.trash_fill),
                        title: Text(S.of(context).deleteAllData),
                        onTap: () {
                          context.read<NotTodoCubit>().deleteAll();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            icon: const Icon(CupertinoIcons.gear_alt_fill),
          ),
        ],
      ),
    );
  }
}
