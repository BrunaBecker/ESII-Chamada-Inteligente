import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';
import '../theme/app_colors.dart';

class ProfilePictureButton extends StatelessWidget {
  const ProfilePictureButton({
    super.key,
    this.image,
  });

  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.profile,
      ),
      child: Container(
        key: const Key('perfil_box'),
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
      ),
    );
  }
}
