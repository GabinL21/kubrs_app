import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/details/cubit/solve_details_cubit.dart';
import 'package:kubrs_app/history/utils/date_time_formatter.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:share_plus/share_plus.dart';

class SolveDetailsShareButton extends StatelessWidget {
  const SolveDetailsShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    final solve = BlocProvider.of<SolveDetailsCubit>(context).state;
    return IconButton(
      onPressed: () {
        _shareSolve(solve).then(
          (value) => {
            if (value == ShareResultStatus.success) _showSuccessSnack(context),
          },
        );
      },
      icon: Icon(
        Icons.share_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Future<ShareResultStatus> _shareSolve(Solve solve) async {
    final solveTime = solve.timeToDisplay;
    final timeAgo = DateTimeFormatter.format(solve.timestamp);
    final shareResult = await Share.shareWithResult(
      'Got a $solveTime 3x3 solve $timeAgo on Kubrs!',
    );
    return shareResult.status;
  }

  void _showSuccessSnack(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Solve successfully shared!'),
      ),
    );
  }
}
