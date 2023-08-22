import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/history/utils/date_time_formatter.dart';
import 'package:kubrs_app/scramble/utils/scramble_visualizer.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/view/solve_details_page.dart';

class SolveTile extends StatelessWidget {
  const SolveTile({super.key, required this.solve});

  final Solve solve;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToSolveDetails(context),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getLeftColumn(context),
            ScrambleVisualizer.getUpFace(scramble: solve.scramble),
          ],
        ),
      ),
    );
  }

  void _navigateToSolveDetails(BuildContext context) {
    final solveBloc = BlocProvider.of<SolveBloc>(context);
    Navigator.of(context).push(
      MaterialPageRoute<Widget>(
        builder: (context) => BlocProvider.value(
          value: solveBloc,
          child: SolveDetailsPage(solve: solve),
        ),
      ),
    );
  }

  Column _getLeftColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getTimeText(context),
        const SizedBox(height: 4),
        _getTimestampText(context),
      ],
    );
  }

  Text _getTimeText(BuildContext context) {
    return Text(
      solve.timeToDisplay,
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
    );
  }

  Text _getTimestampText(BuildContext context) {
    return Text(
      DateTimeFormatter.format(solve.timestamp),
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14,
          ),
    );
  }
}
