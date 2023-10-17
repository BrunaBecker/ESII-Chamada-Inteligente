import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ProfilePictureButton extends StatelessWidget {
  const ProfilePictureButton({
    super.key,
    this.image,
  });

  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        shape: BoxShape.circle,
        image: image != null
            ? DecorationImage(
                image: image!,
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }
}