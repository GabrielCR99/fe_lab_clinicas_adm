import 'package:flutter/material.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import 'checkin_image_dialog.dart';

final class CheckinImageLink extends StatelessWidget {
  final String label;
  final String image;

  const CheckinImageLink({required this.label, required this.image, super.key});

  void showImageDialog(BuildContext context) => showDialog<void>(
        context: context,
        builder: (context) => CheckinImageDialog(context, imagePath: image),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showImageDialog(context),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          label,
          style: const TextStyle(
            color: blueColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
