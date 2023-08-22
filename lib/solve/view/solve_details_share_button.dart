import 'package:flutter/material.dart';
import 'package:kubrs_app/history/utils/date_time_formatter.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:share_plus/share_plus.dart';

class SolveDetailsShareButton extends StatelessWidget {
  const SolveDetailsShareButton({super.key, required this.solve});

  final Solve solve;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _shareSolve,
      icon: Icon(
        Icons.share_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _shareSolve() {
    final solveTime = solve.timeToDisplay;
    final timeAgo = DateTimeFormatter.format(solve.timestamp);
    Share.share('Got a $solveTime 3x3 solve $timeAgo on Kubrs!');
  }
}
