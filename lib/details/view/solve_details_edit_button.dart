import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/details/cubit/solve_details_cubit.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class SolveDetailsEditButton extends StatelessWidget {
  const SolveDetailsEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showEditDialog(context),
      icon: Icon(
        Icons.edit_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final editDialog = _getEditDialog(context);
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return editDialog;
      },
    );
  }

  Widget _getEditDialog(BuildContext context) {
    final solveDetailsCubit = BlocProvider.of<SolveDetailsCubit>(context);
    final solveBloc = BlocProvider.of<SolveBloc>(context);
    final alert = MultiBlocProvider(
      providers: [
        BlocProvider.value(value: solveDetailsCubit),
        BlocProvider.value(value: solveBloc),
      ],
      child: BlocBuilder<SolveDetailsCubit, Solve>(
        builder: (context, solve) {
          return AlertDialog(
            content: _getEditDialogContent(context, solve),
          );
        },
      ),
    );
    return alert;
  }

  Widget _getEditDialogContent(BuildContext context, Solve solve) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text('+2'),
          leading: Switch(
            value: solve.plusTwo,
            onChanged: (_) => _togglePlusTwo(context),
          ),
        ),
        ListTile(
          title: const Text('DNF'),
          leading: Switch(
            value: solve.dnf,
            onChanged: (_) => _toggleDnf(context),
          ),
        ),
      ],
    );
  }

  void _togglePlusTwo(BuildContext context) {
    final solveDetailsCubit = BlocProvider.of<SolveDetailsCubit>(context);
    final solve = solveDetailsCubit.state;
    solveDetailsCubit.togglePlusTwo();
    BlocProvider.of<SolveBloc>(context).add(TogglePlusTwoTag(solve: solve));
  }

  void _toggleDnf(BuildContext context) {
    final solveDetailsCubit = BlocProvider.of<SolveDetailsCubit>(context);
    final solve = solveDetailsCubit.state;
    solveDetailsCubit.toggleDnf();
    BlocProvider.of<SolveBloc>(context).add(ToggleDNFTag(solve: solve));
  }
}
