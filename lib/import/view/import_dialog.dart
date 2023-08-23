import 'package:flutter/material.dart';
import 'package:kubrs_app/import/utils/cstimer_solve_parser.dart';
import 'package:kubrs_app/import/view/import_dialog_option.dart';

class ImportDialog extends StatelessWidget {
  const ImportDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleDialog(
      title: Text('From which timer do you want to import solves?'),
      children: [
        ImportDialogOption(
          timerName: 'csTimer',
          solveParser: CSTimerSolveParser.parseSolves,
        ),
      ],
    );
  }
}
