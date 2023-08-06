import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key});

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
    final cancelButton = TextButton(
      child: const Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    final continueButton = TextButton(
      child: const Text('Delete'),
      onPressed: () {
        _deleteLastSolve(context);
        _reinitializeTimer(context);
        Navigator.of(context).pop();
      },
    );
    final alert = AlertDialog(
      content: const Text(
        'Delete your last solve?',
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
