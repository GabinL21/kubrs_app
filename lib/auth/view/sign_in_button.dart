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
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: _getButton(theme),
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
      style: _getButtonStyle(theme),
    );
  }

  ButtonStyle _getButtonStyle(ThemeData theme) {
    return ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(theme.colorScheme.surface),
      overlayColor: MaterialStatePropertyAll(
        theme.colorScheme.tertiary.withOpacity(0.05),
      ),
      padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
