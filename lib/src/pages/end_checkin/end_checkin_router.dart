import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'end_checkin_controller.dart';
import 'end_checkin_page.dart';

final class EndCheckinRouter extends FlutterGetItPageRouter {
  const EndCheckinRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
          (i) => EndCheckinController(callNextPatientService: i()),
        ),
      ];

  @override
  String get routeName => '/end-checkin';

  @override
  WidgetBuilder get view => (context) => const EndCheckinPage();
}
