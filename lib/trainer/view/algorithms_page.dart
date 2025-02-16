import 'package:flutter/material.dart';
import 'package:kubrs_app/trainer/model/algorithm_group.dart';
import 'package:kubrs_app/trainer/view/algorithms_list.dart';
import 'package:kubrs_app/trainer/view/train_button.dart';
import 'package:kubrs_app/trainer/view/trainer_timer_page.dart';

class AlgorithmsPage extends StatelessWidget {
  const AlgorithmsPage({super.key, required this.algorithmGroup});

  final AlgorithmGroup algorithmGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: AlgorithmsView(algorithmGroup: algorithmGroup),
    );
  }
}

class AlgorithmsView extends StatelessWidget {
  const AlgorithmsView({super.key, required this.algorithmGroup});

  final AlgorithmGroup algorithmGroup;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AlgorithmsList(group: algorithmGroup),
          ),
          const SizedBox(height: 16),
          TrainButton(
            label: 'Train',
            onPressed: () => _navigateToTrainerTimerPage(context),
          ),
        ],
      ),
    );
  }

  void _navigateToTrainerTimerPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<Widget>(
        builder: (context) => TrainerTimerPage(algorithmGroup: algorithmGroup),
      ),
    );
  }
}
