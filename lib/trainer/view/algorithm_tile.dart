import 'package:flutter/material.dart';
import 'package:kubrs_app/scramble/utils/scramble_visualizer.dart';
import 'package:kubrs_app/trainer/model/algorithm.dart';

class AlgorithmTile extends StatelessWidget {
  const AlgorithmTile({super.key, required this.algorithm});

  final Algorithm algorithm;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          _getLeftColumn(context),
        ],
      ),
    );
  }

  Column _getLeftColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrambleVisualizer.fromCubePattern(
          cubePattern: algorithm.pattern,
          size: 10,
        ).getUpFaceWithSides(),
        const SizedBox(height: 12),
        _getAlgorithmName(context),
        const SizedBox(height: 4),
        _getAlgorithmSolution(context),
      ],
    );
  }

  Text _getAlgorithmName(BuildContext context) {
    return Text(
      algorithm.name,
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
    );
  }

  Text _getAlgorithmSolution(BuildContext context) {
    return Text(
      algorithm.solution,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14,
          ),
    );
  }
}
