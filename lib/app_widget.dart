import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import 'src/bindings/lab_clinicas_app_binding.dart';
import 'src/pages/checkin/checkin_router.dart';
import 'src/pages/end_checkin/end_checkin_router.dart';
import 'src/pages/home/home_router.dart';
import 'src/pages/login/login_router.dart';
import 'src/pages/pre_checkin/pre_checkin_router.dart';
import 'src/pages/splash/splash_page.dart';

final class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      bindings: LabClinicasAppBinding(),
      routes: const [
        LoginRouter(),
        HomeRouter(),
        PreCheckinRouter(),
        CheckinRouter(),
        EndCheckinRouter(),
      ],
      pageBuilders: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/'),
      ],
      title: 'Lab Clínicas ADM',
    );
  }
}
