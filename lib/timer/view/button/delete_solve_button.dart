import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';

class DeleteSolveButton extends StatelessWidget {
  const DeleteSolveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close_rounded),
      color: Theme.of(context).colorScheme.secondary,
      onPressed: () {
        _showConfirmationDialog(context);
      },
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    final confirmationDialog = _getConfirmationDialog(context);
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return confirmationDialog;
      },
    );
  }

  AlertDialog _getConfirmationDialog(BuildContext context) {
    final cancelButton = _getCancelButton(context);
    final deleteButton = _getDeleteButton(context);
    final alert = AlertDialog(
      content: const Text(
        'Delete your last solve?',
      ),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    return alert;
  }

  TextButton _getCancelButton(BuildContext context) {
    final cancelButton = TextButton(
      child: Text(
        'Cancel',
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    return cancelButton;
  }

  TextButton _getDeleteButton(BuildContext context) {
    final continueButton = TextButton(
      child: Text(
        'Delete',
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
      onPressed: () {
        _deleteLastSolve(context);
        _reinitializeTimer(context);
        Navigator.of(context).pop();
      },
    );
    return continueButton;
  }

  void _deleteLastSolve(BuildContext context) {
    final solveBloc = BlocProvider.of<SolveBloc>(context);
    if (solveBloc.state is! SolveDone) return;
    final lastSolve = (solveBloc.state as SolveDone).solve;
    solveBloc.add(DeleteSolve(solve: lastSolve));
  }

  void _reinitializeTimer(BuildContext context) {
    BlocProvider.of<TimerBloc>(context).add(const ReinitializeTimer());
  }
}
