import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kubrs_app/import/utils/cstimer_solve_importer.dart';
import 'package:kubrs_app/import/utils/solve_importer.dart';

class ImportDialog extends StatelessWidget {
  const ImportDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: _getTitle(context),
      children: [
        _getOption('csTimer', CSTimerSolveImporter(), context),
      ],
    );
  }

  Widget _getTitle(BuildContext context) {
    return Text(
      'From which timer do you want to import solves?',
      style: Theme.of(context).textTheme.displayMedium,
    );
  }

  Widget _getOption(
    String timerName,
    SolveImporter solveImporter,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return SimpleDialogOption(
      onPressed: () {
        _launchImportProcess(solveImporter);
        Navigator.pop(context);
      },
      child: Text(
        timerName,
        style: theme.textTheme.displaySmall
            ?.copyWith(color: theme.colorScheme.secondary),
      ),
    );
  }

  Future<void> _launchImportProcess(SolveImporter solveImporter) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.single.path == null) return;
    final file = File(result.files.single.path!);
    final rawData = await file.readAsString();
    final solves = solveImporter.convertRawDataToSolves(rawData);
  }
}
