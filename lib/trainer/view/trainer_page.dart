import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/profile/bloc/profile_bloc.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

class TrainerPage extends StatelessWidget {
  const TrainerPage({
    super.key,
    required this.solveRepository,
  });

  final SolveRepository solveRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(solveRepository: solveRepository),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: const TrainerView(),
      ),
    );
  }
}

class TrainerView extends StatelessWidget {
  const TrainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
