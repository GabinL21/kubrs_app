import 'package:flutter/material.dart';
import 'package:kubrs_app/trainer/model/algorithm_group.dart';
import 'package:kubrs_app/trainer/view/algorithms_list.dart';

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
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
      child: AlgorithmsList(group: algorithmGroup),
    );
  }
}
