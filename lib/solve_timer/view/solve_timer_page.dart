import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/solve_timer/bloc/solve_timer_bloc.dart';

class SolveTimerPage extends StatelessWidget {
  const SolveTimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SolveTimerBloc(),
      child: const SolveTimerView(),
    );
  }
}

class SolveTimerView extends StatelessWidget {
  const SolveTimerView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
