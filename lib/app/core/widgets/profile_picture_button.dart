import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';
import 'profile_picture.dart';

class ProfilePictureButton extends StatelessWidget {
  const ProfilePictureButton({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.profile,
      ),
      child: Container(
        key: const Key('perfil_box'),
        child: ProfilePicture(
          imageUrl: image,
        ),
      ),
    );
  }
}
