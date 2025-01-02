import 'package:flutter/material.dart';
import 'package:kubrs_app/trainer/view/groups_list.dart';

class TrainerPage extends StatelessWidget {
  const TrainerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: const TrainerView(),
    );
  }
}

class TrainerView extends StatelessWidget {
  const TrainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
      child: GroupsList(),
    );
  }
}
