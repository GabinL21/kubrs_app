import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

class ImportConfirmationDialog extends StatelessWidget {
  const ImportConfirmationDialog({super.key, required this.solves});

  final List<Solve> solves;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('Do you want to import ${solves.length} solves?'),
      actions: [
        _getCancelButton(context),
        _getImportButton(context),
      ],
    );
  }

  TextButton _getCancelButton(BuildContext context) {
    return TextButton(
      child: Text(
        'Cancel',
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
      onPressed: () {
        Navigator.pop(context); // Pop confirmation dialog
      },
    );
  }

  TextButton _getImportButton(BuildContext context) {
    return TextButton(
      child: Text(
        'Import',
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
      ),
      onPressed: () => {
        _importSolves(solves),
        Navigator.pop(context), // Pop confirmation dialog
      },
    );
  }

  void _importSolves(List<Solve> solves) {
    final solveRepository = SolveRepository();
    for (final solve in solves) {
      unawaited(solveRepository.addSolve(solve));
    }
  }
}
