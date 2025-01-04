import 'package:flutter/material.dart';
import 'package:kubrs_app/trainer/model/algorithm_group.dart';
import 'package:kubrs_app/trainer/view/trainer_timer_page.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({super.key, required this.group});

  final AlgorithmGroup group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToTrainerTimerPage(context),
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getLeftColumn(context),
          ],
        ),
      ),
    );
  }

  Column _getLeftColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getGroupName(context),
        const SizedBox(height: 4),
        _getGroupSize(context),
      ],
    );
  }

  Text _getGroupName(BuildContext context) {
    return Text(
      group.name,
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
    );
  }

  Text _getGroupSize(BuildContext context) {
    return Text(
      '${group.algorithms.length} algorithms',
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14,
          ),
    );
  }

  void _navigateToTrainerTimerPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<Widget>(
        builder: (context) => const TrainerTimerPage(),
      ),
    );
  }
}
