import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/auth/auth.dart';
import 'package:kubrs_app/import/view/import_dialog.dart';
import 'package:kubrs_app/user/bloc/user_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 96, 32, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getHeader(context),
            _getFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return Text(
            state.userName,
            style: Theme.of(context).textTheme.displayMedium,
          );
        }
        return Text(
          'Loading...',
          style: Theme.of(context).textTheme.displayMedium,
        );
      },
    );
  }

  Widget _getFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getImportButton(context),
        _getDonateButton(context),
        _getSignOutButton(context),
      ],
    );
  }

  Widget _getImportButton(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return TextButton.icon(
      onPressed: () => _showImportDialog(context),
      icon: Icon(Icons.import_export_outlined, color: color),
      label: Text(
        'Import',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }

  Widget _getDonateButton(BuildContext context) {
    final url = Uri.parse('https://ko-fi.com/kubrs');
    final color = Theme.of(context).colorScheme.primary;
    return TextButton.icon(
      onPressed: () async =>
          {if (await canLaunchUrl(url)) await launchUrl(url)},
      icon: Icon(Icons.attach_money_outlined, color: color),
      label: Text(
        'Donate',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }

  Widget _getSignOutButton(BuildContext context) {
    final color = Theme.of(context).colorScheme.error;
    return TextButton.icon(
      onPressed: () => context.read<AuthBloc>().add(SignOutRequested()),
      icon: Icon(Icons.logout_outlined, color: color),
      label: Text(
        'Sign out',
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: color,
            ),
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
