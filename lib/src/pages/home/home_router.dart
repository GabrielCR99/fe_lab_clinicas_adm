import 'package:flutter/widgets.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'home_controller.dart';
import 'home_page.dart';

final class HomeRouter extends FlutterGetItPageRouter {
  const HomeRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
          (i) => HomeController(
            attendantDeskAssignmentRepository: i(),
            callNextPatientService: i(),
          ),
        ),
      ];

  @override
  String get routeName => '/home';

  @override
  WidgetBuilder get view => (_) => const HomePage();
}
