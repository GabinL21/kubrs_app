import 'package:flutter/material.dart';

class TrainButton extends StatelessWidget {
  const TrainButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

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
    return TextButton(
      onPressed: onPressed,
      style: _getButtonStyle(theme),
      child: Text(
        label,
        style: theme.textTheme.displayMedium,
      ),
    );
  }

  ButtonStyle _getButtonStyle(ThemeData theme) {
    return ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(theme.colorScheme.surface),
      padding: const MaterialStatePropertyAll(
        EdgeInsets.fromLTRB(36, 12, 36, 12),
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
