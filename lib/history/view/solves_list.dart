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
        final historyBloc = BlocProvider.of<HistoryBloc>(context);
        if (state is HistoryInitial) {
          historyBloc.add(const GetFirstHistory());
        }
        if (state is HistoryInitial || state is HistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final solves = state.solves;
        final nbSolves = solves.length;
        if (nbSolves == 0) {
          return Center(
            child: Text(
              'No solves',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          );
        }
        final nbItems =
            state is HistoryLoadingNext || state is HistoryFullyLoaded
                ? nbSolves + 1
                : nbSolves;
        return RefreshIndicator(
          onRefresh: () => refreshHistory(historyBloc),
          child: ListView.separated(
            itemCount: nbItems,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index == nbItems - 1) {
                if (state is HistoryLoadingNext) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is HistoryFullyLoaded) {
                  return const SizedBox(height: 16); // Bottom padding
                }
              }
              return SolveTile(solve: solves[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          ),
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
    final historyBloc = context.read<HistoryBloc>();
    if (historyBloc.state is! HistoryLoaded) return;
    if (_isBottom) historyBloc.add(const GetNextHistory());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Future<void> refreshHistory(HistoryBloc historyBloc) async {
    historyBloc.add(const RefreshHistory());
    return Future.doWhile(
      () =>
          historyBloc.state is! HistoryLoaded &&
          historyBloc.state is! HistoryFullyLoaded,
    );
  }
}
