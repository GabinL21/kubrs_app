import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/trainer/bloc/algorithm_scramble_bloc.dart';
import 'package:kubrs_app/trainer/bloc/algorithms_bloc.dart';
import 'package:kubrs_app/trainer/view/group_tile.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlgorithmsBloc>(
          create: (context) => AlgorithmsBloc(),
        ),
        BlocProvider<AlgorithmScrambleBloc>(
          create: (context) => AlgorithmScrambleBloc(),
        ),
      ],
      child: _getGroupsList(context),
    );
  }

  Widget _getGroupsList(BuildContext context) {
    return BlocBuilder<AlgorithmsBloc, AlgorithmsState>(
      builder: (context, state) {
        if (state is! AlgorithmsLoaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final groups = state.algorithmGroups;
        final nbGroups = groups.length;
        if (nbGroups == 0) {
          return Center(
            child: Text(
              'No algorithms',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ListView.separated(
            itemCount: nbGroups,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GroupTile(group: groups[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          ),
        );
      },
    );
  }
}
