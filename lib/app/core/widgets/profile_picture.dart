import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Widget errorIcon = Container(
      decoration: const BoxDecoration(
        color: AppColors.lightGray,
        shape: BoxShape.circle,
      ),
    );

    if (imageUrl.isEmpty) {
      return errorIcon;
    }

    try {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(
              imageUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    } catch (_) {}

    return ClipOval(
      child: errorIcon,
    );
  }
}
