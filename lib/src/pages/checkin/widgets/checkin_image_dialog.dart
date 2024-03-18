import 'package:flutter/material.dart';

import '../../../core/env.dart';

final class CheckinImageDialog extends AlertDialog {
  CheckinImageDialog(
    BuildContext context, {
    required String imagePath,
    super.key,
  }) : super(
          content:
              Image.network('$backendBaseUrl/$imagePath', fit: BoxFit.cover),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Fechar'),
            ),
          ],
        );
}
