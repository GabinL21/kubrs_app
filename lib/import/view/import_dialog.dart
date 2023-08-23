import 'package:flutter/material.dart';

class ImportDialog extends StatelessWidget {
  const ImportDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: _getTitle(context),
      children: [
        _getOption('csTimer', context),
      ],
    );
  }

  Widget _getTitle(BuildContext context) {
    return Text(
      'From which timer do you want to import solves?',
      style: Theme.of(context).textTheme.displayMedium,
    );
  }

  Widget _getOption(String timerName, BuildContext context) {
    final theme = Theme.of(context);
    return SimpleDialogOption(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        timerName,
        style: theme.textTheme.displaySmall
            ?.copyWith(color: theme.colorScheme.secondary),
      ),
    );
  }
}
