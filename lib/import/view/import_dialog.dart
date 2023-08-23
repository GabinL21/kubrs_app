import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kubrs_app/import/utils/cstimer_solve_importer.dart';
import 'package:kubrs_app/import/utils/solve_importer.dart';
import 'package:kubrs_app/import/view/import_confirmation_dialog.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class ImportDialog extends StatelessWidget {
  const ImportDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('From which timer do you want to import solves?'),
      children: [
        _getOption('csTimer', CSTimerSolveImporter(), context),
      ],
    );
  }

  Widget _getOption(
    String timerName,
    SolveImporter solveImporter,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return SimpleDialogOption(
      onPressed: () => _getOptionAction(solveImporter, context),
      child: Text(
        timerName,
        style: theme.textTheme.displaySmall
            ?.copyWith(color: theme.colorScheme.secondary),
      ),
    );
  }

  Future<void> _getOptionAction(
    SolveImporter solveImporter,
    BuildContext context,
  ) async {
    final List<Solve> solves;
    try {
      solves = await _launchImportProcess(solveImporter);
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context); // Pop import dialog
      _displayErrorSnackBar(context);
      return;
    }
    if (!context.mounted) return;
    Navigator.pop(context); // Pop import dialog
    if (solves.isNotEmpty) {
      _displayConfirmationDialog(solves, context);
    }
  }

  Future<List<Solve>> _launchImportProcess(SolveImporter solveImporter) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.single.path == null) return List.empty();
    final file = File(result.files.single.path!);
    final rawData = await file.readAsString();
    return solveImporter.convertRawDataToSolves(rawData);
  }

  void _displayConfirmationDialog(List<Solve> solves, BuildContext context) {
    showDialog<ImportConfirmationDialog>(
      context: context,
      builder: (_) => ImportConfirmationDialog(solves: solves),
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
