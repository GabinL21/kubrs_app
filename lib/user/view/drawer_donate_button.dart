import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerDonateButton extends StatelessWidget {
  const DrawerDonateButton({super.key});

  static const String label = 'Donate';
  static final Uri donationUrl = Uri.parse('https://ko-fi.com/kubrs');

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return TextButton.icon(
      onPressed: () async => _openDonationUrl(),
      icon: Icon(Icons.attach_money_outlined, color: color),
      label: Text(
        label,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }

  Future<void> _openDonationUrl() async {
    if (await canLaunchUrl(donationUrl)) {
      await launchUrl(donationUrl);
    }
  }
}
