import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.leadingIcon,
    this.trailingIcon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: leadingIcon,
        trailing: trailingIcon,
        tileColor: AppColors.surfaceContainer,
        onTap: onTap,
      ),
    );
  }
}
