import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kubrs_app/import/utils/cstimer_solve_parser.dart';
import 'package:kubrs_app/import/utils/solve_parser.dart';
import 'package:kubrs_app/import/view/import_confirmation_dialog.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class ImportDialog extends StatelessWidget {
  const ImportDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('From which timer do you want to import solves?'),
      children: [
        _getOption('csTimer', CSTimerSolveParser.parseSolves, context),
      ],
    );
  }

  Widget _getOption(
    String timerName,
    SolveParser solveParser,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return SimpleDialogOption(
      onPressed: () => _getOptionAction(solveParser, context),
      child: Text(
        timerName,
        style: theme.textTheme.displaySmall
            ?.copyWith(color: theme.colorScheme.secondary),
      ),
    );
  }

  void _getOptionAction(
    SolveParser solveParser,
    BuildContext context,
  ) {
    try {
      _launchImportProcess(solveParser, context);
    } catch (_) {
      _handleError(context);
    }
  }

  void _launchImportProcess(SolveParser solveParser, BuildContext context) {
    FilePicker.platform
        .pickFiles()
        .then((result) => _processResult(result, solveParser, context))
        .catchError((_) => _handleError(context));
  }

  void _processResult(
    FilePickerResult? result,
    SolveParser solveParser,
    BuildContext context,
  ) {
    if (result == null || result.files.single.path == null) return;
    final file = File(result.files.single.path!);
    file
        .readAsString()
        .then(
          (textSolves) => _processTextSolves(textSolves, solveParser, context),
        )
        .catchError((_) => _handleError(context));
    ;
  }

  void _processTextSolves(
    String textSolves,
    SolveParser solveParser,
    BuildContext context,
  ) {
    try {
      final solves = solveParser.call(textSolves);
      Navigator.pop(context); // Pop import dialog
      _displayConfirmationDialog(solves, context);
    } catch (_) {
      _handleError(context);
    }
  }

  void _displayConfirmationDialog(List<Solve> solves, BuildContext context) {
    showDialog<ImportConfirmationDialog>(
      context: context,
      builder: (_) => ImportConfirmationDialog(solves: solves),
    );
  }

  void _handleError(BuildContext context) {
    Navigator.pop(context); // Pop import dialog
    _displayErrorSnackBar(context);
  }

  void _displayErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Importation failed, check your file'),
      ),
    );
  }
}
