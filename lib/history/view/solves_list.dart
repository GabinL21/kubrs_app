import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/history/bloc/history_bloc.dart';
import 'package:kubrs_app/history/view/solve_tile.dart';

class SolvesList extends StatefulWidget {
  const SolvesList({super.key});

  @override
  State<SolvesList> createState() => _SolvesListState();
}

class _SolvesListState extends State<SolvesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistoryInitial || state is HistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final solves = state.solves;
        final nbSolves = solves.length;
        if (nbSolves == 0) return const Text('No solves');
        return ListView.separated(
          itemCount: nbSolves,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context, index) {
            return SolveTile(solve: solves[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<HistoryBloc>().add(const GetHistory());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
