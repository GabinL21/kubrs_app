import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.iconData,
    required this.label,
    required this.onPressed,
  });

  final IconData iconData;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: _getButton(theme),
      ),
    );
  }

  TextButton _getButton(ThemeData theme) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: theme.colorScheme.primary,
      ),
      label: Text(
        label,
        style: theme.textTheme.displayMedium,
      ),
    );
  }
}
