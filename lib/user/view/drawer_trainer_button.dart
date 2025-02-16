import 'package:flutter/material.dart';
import 'package:kubrs_app/trainer/view/groups_page.dart';

class DrawerTrainerButton extends StatelessWidget {
  const DrawerTrainerButton({super.key});

  static const String label = 'Trainer';

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return TextButton.icon(
      onPressed: () => _navigateToTrainerPage(context),
      icon: Icon(Icons.school_outlined, color: color),
      label: Text(
        label,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }

  void _navigateToTrainerPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<Widget>(
        builder: (context) => const GroupsPage(),
      ),
    );
  }
}
