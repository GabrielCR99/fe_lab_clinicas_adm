import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'end_checkin_controller.dart';

final class EndCheckinPage extends StatefulWidget {
  const EndCheckinPage({super.key});

  @override
  State<EndCheckinPage> createState() => _EndCheckinPageState();
}

final class _EndCheckinPageState extends State<EndCheckinPage> {
  final _controller = Injector.get<EndCheckinController>();
  @override
  void initState() {
    super.initState();
    context.messageListener(_controller);
    effect(() {
      if (_controller.informationForm() != null) {
        Navigator.of(context).pushReplacementNamed<void, void>(
          '/pre-checkin',
          arguments: _controller.informationForm(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border.fromBorderSide(BorderSide(color: orangeColor)),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          width: sizeOf.width * 0.4,
          margin: const EdgeInsets.only(top: 56),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/check_icon.png'),
              const SizedBox(height: 40),
              const Text(
                'Atendimento finalizado com sucesso!',
                style: titleSmallStyle,
              ),
              const SizedBox(height: 80),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _controller.callNextPatient,
                  child: const Text('CHAMAR OUTRA SENHA'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
