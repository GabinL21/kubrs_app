import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/import/utils/cstimer_solve_parser.dart';
import 'package:kubrs_app/import/utils/cube_desk_solve_parser.dart';
import 'package:kubrs_app/import/utils/twisty_timer_solve_parser.dart';
import 'package:kubrs_app/import/view/import_dialog_option.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

class ImportDialog extends StatelessWidget {
  const ImportDialog({super.key, required this.solveRepository});

  final SolveRepository solveRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: solveRepository,
      child: const SimpleDialog(
        title: Text('From which timer do you want to import solves?'),
        children: [
          ImportDialogOption(
            timerName: 'csTimer',
            solveParser: CSTimerSolveParser.parseSolves,
          ),
          ImportDialogOption(
            timerName: 'Twisty Timer',
            solveParser: TwistyTimerSolveParser.parseSolves,
          ),
          ImportDialogOption(
            timerName: 'CubeDesk',
            solveParser: CubeDeskSolveParser.parseSolves,
          ),
        ],
      ),
    );
  }
}
