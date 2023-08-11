import 'package:flutter/material.dart';
import 'package:kubrs_app/history/utils/date_time_formatter.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class SolveTile extends StatelessWidget {
  const SolveTile({super.key, required this.solve});

  final Solve solve;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _getLeftColumn(context),
        ],
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
          ),
    );
  }

  Text _getTimestampText(BuildContext context) {
    return Text(
      DateTimeFormatter.format(solve.timestamp),
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
    );
  }
}
