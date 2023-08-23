import 'package:flutter/material.dart';
import 'package:kubrs_app/user/view/drawer_donate_button.dart';
import 'package:kubrs_app/user/view/drawer_import_button.dart';
import 'package:kubrs_app/user/view/drawer_profile_header.dart';
import 'package:kubrs_app/user/view/drawer_sign_out_button.dart';

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
            const DrawerProfileHeader(),
            _getFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _getFooter(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerImportButton(),
        DrawerDonateButton(),
        DrawerSignOutButton(),
      ],
    );
  }
}
