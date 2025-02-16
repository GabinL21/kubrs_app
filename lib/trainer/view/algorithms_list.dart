import 'package:flutter/material.dart';
import 'package:kubrs_app/trainer/model/algorithm_group.dart';
import 'package:kubrs_app/trainer/view/algorithm_tile.dart';

class AlgorithmsList extends StatelessWidget {
  const AlgorithmsList({super.key, required this.group});

  final AlgorithmGroup group;

  @override
  Widget build(BuildContext context) {
    return _getAlgorithmsList(context);
  }

  Widget _getAlgorithmsList(BuildContext context) {
    final nbAlgorithms = group.algorithms.length;
    if (nbAlgorithms == 0) {
      return Center(
        child: Text(
          'No algorithms',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SingleChildScrollView(
        child: ListView.separated(
          itemCount: nbAlgorithms,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return AlgorithmTile(algorithm: group.algorithms[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        ),
      ),
    );
  }
}
