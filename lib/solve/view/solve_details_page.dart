import 'package:flutter/material.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class SolveDetailsPage extends StatelessWidget {
  const SolveDetailsPage({super.key, required this.solve});

  final Solve solve;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SolveDetailsView(solve: solve));
  }
}

class SolveDetailsView extends StatelessWidget {
  const SolveDetailsView({super.key, required this.solve});

  final Solve solve;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getSolveTime(solve),
      ],
    );
  }

  Widget _getSolveTime(Solve solve) {
    return Text(solve.timeToDisplay);
  }
}
