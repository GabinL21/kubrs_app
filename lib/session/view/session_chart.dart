import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/session/bloc/session_bloc.dart';
import 'package:kubrs_app/stats/view/time_chart.dart';

class SessionChart extends StatelessWidget {
  const SessionChart({super.key});

  static const minSolves = 24;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        return TimeChart(
          solves: state.solves.where((s) => !s.dnf).toList(),
          minimalist: true,
          minSolves: minSolves,
        );
      },
    );
  }
}
