import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/history/bloc/history_bloc.dart';
import 'package:kubrs_app/history/repository/history_repository.dart';
import 'package:kubrs_app/history/view/solves_list.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => HistoryRepository(),
      child: BlocProvider(
        create: (context) => HistoryBloc(
          historyRepository: RepositoryProvider.of<HistoryRepository>(context),
        ),
        child: const HistoryView(),
      ),
    );
  }
}

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HistoryBloc>().add(const GetHistory());
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Center(
        child: SolvesList(),
      ),
    );
  }
}
