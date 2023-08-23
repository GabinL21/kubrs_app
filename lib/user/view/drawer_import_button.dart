import 'package:flutter/material.dart';
import 'package:kubrs_app/import/view/import_dialog.dart';

class DrawerImportButton extends StatelessWidget {
  const DrawerImportButton({super.key});

  static const String label = 'Import';

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return TextButton.icon(
      onPressed: () => _showImportDialog(context),
      icon: Icon(Icons.import_export_outlined, color: color),
      label: Text(
        label,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }

  void _showImportDialog(BuildContext context) {
    Navigator.pop(context); // Pop drawer
    showDialog<ImportDialog>(
      context: context,
      builder: (_) => const ImportDialog(),
    );
  }
}
