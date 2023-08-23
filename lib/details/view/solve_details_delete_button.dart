import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/details/cubit/solve_details_cubit.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';

class SolveDetailsDeleteButton extends StatelessWidget {
  const SolveDetailsDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showConfirmationDialog(context),
      icon: Icon(
        Icons.delete_outline,
        color: Theme.of(context).colorScheme.primary,
      ),
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
        'Delete this solve?',
      ),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    return alert;
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
        Navigator.pop(context); // Pop dialog
      },
    );
  }

  TextButton _getDeleteButton(BuildContext context) {
    return TextButton(
      child: Text(
        'Delete',
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
      onPressed: () {
        _deleteSolve(context);
        Navigator.pop(context); // Pop dialog
        Navigator.pop(context); // Pop solve details
      },
    );
  }

  void _deleteSolve(BuildContext context) {
    final solve = BlocProvider.of<SolveDetailsCubit>(context).state;
    final deleteSolveEvent = DeleteSolve(solve: solve);
    BlocProvider.of<SolveBloc>(context).add(deleteSolveEvent);
  }
}
