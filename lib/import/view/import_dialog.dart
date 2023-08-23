import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kubrs_app/import/utils/cstimer_solve_parser.dart';
import 'package:kubrs_app/import/utils/twisty_timer_solve_parser.dart';
import 'package:kubrs_app/import/view/import_dialog_option.dart';

class ImportDialog extends StatelessWidget {
  const ImportDialog({super.key});

  static final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('From which timer do you want to import solves?'),
      children: [
        ImportDialogOption(
          timerName: 'csTimer',
          solveParser: CSTimerSolveParser(uid: uid).parseSolves,
        ),
        ImportDialogOption(
          timerName: 'Twisty Timer',
          solveParser: TwistyTimerSolveParser(uid: uid).parseSolves,
        ),
      ],
    );
  }
}
