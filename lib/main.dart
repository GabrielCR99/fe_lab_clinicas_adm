import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'app_widget.dart';

void main() => runZonedGuarded<void>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        return runApp(const AppWidget());
      },
      (error, stackTrace) {
        log('runZonedGuarded: $error');
        log('runZonedGuarded: $stackTrace');

        Error.throwWithStackTrace(error, stackTrace);
      },
    );
