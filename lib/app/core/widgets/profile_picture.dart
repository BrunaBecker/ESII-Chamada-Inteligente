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
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        errorBuilder: (context, error, stackTrace) => errorIcon,
      );
    } catch (_) {}

    return ClipOval(
      child: errorIcon,
    );
  }
}
