import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/import/utils/solve_parser.dart';
import 'package:kubrs_app/import/view/import_confirmation_dialog.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

class ImportDialogOption extends StatelessWidget {
  const ImportDialogOption({
    super.key,
    required this.timerName,
    required this.solveParser,
  });

  final String timerName;
  final SolveParser solveParser;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SimpleDialogOption(
      onPressed: () => _launchImportProcess(context),
      child: Text(
        timerName,
        style: theme.textTheme.displaySmall
            ?.copyWith(color: theme.colorScheme.secondary),
      ),
    );
  }

  void _launchImportProcess(BuildContext context) {
    FilePicker.platform
        .pickFiles()
        .then((result) => _processResult(result, context));
  }

  void _processResult(FilePickerResult? result, BuildContext context) {
    if (result == null || result.files.single.path == null) return;
    Navigator.pop(context); // Pop import dialog
    File(result.files.single.path!)
        .readAsString()
        .then((textSolves) => _processTextSolves(textSolves, context))
        .catchError(
          (_) => _displayErrorSnackBar(context), // Catch wrong file formats
        );
  }

  void _processTextSolves(String textSolves, BuildContext context) {
    try {
      final solves = solveParser.call(textSolves);
      _displayConfirmationDialog(solves, context);
    } catch (_) {
      _displayErrorSnackBar(context); // Catch parsing errors
    }
  }

  void _displayConfirmationDialog(List<Solve> solves, BuildContext context) {
    final solveRepository = RepositoryProvider.of<SolveRepository>(context);
    showDialog<ImportConfirmationDialog>(
      context: context,
      builder: (_) => ImportConfirmationDialog(
        solves: solves,
        solveRepository: solveRepository,
      ),
    );
  }

  void _displayErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Importation failed, check your file'),
      ),
    );
  }
}
