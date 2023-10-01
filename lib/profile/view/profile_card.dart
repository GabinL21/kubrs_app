import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: theme.colorScheme.shadow,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        child: _getContent(theme),
      ),
    );
  }

  Widget _getContent(ThemeData theme) {
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.displayMedium
              ?.copyWith(color: theme.colorScheme.secondary, fontSize: 14),
        ),
        Text(
          value,
          style: theme.textTheme.displayLarge?.copyWith(fontSize: 32),
        ),
      ],
    );
  }
}
