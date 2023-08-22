import 'package:flutter/material.dart';

class SolveDetailsEditButton extends StatelessWidget {
  const SolveDetailsEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => {},
      icon: Icon(
        Icons.edit_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
