import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

import 'home_controller.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _deskNumberEC = TextEditingController();
  final _controller = Injector.get<HomeController>();

  @override
  void initState() {
    super.initState();
    context.messageListener(_controller);
    effect(() {
      if (_controller.informationForm != null) {
        Navigator.of(context).pushReplacementNamed<void, void>(
          '/pre-checkin',
          arguments: _controller.informationForm,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border.fromBorderSide(BorderSide(color: orangeColor)),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          width: sizeOf.width * 0.4,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Bem-vindo!',
                  style: titleStyle,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Preencha o número do guichê que você está atendendo.',
                  style: subtitleSmallStyle,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _deskNumberEC,
                  decoration:
                      const InputDecoration(labelText: 'Número do guichê'),
                  keyboardType: TextInputType.number,
                  validator: Validatorless.multiple([
                    Validatorless.required('Campo obrigatório'),
                    Validatorless.number('Apenas números'),
                  ]),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () =>
                        switch (_formKey.currentState?.validate()) {
                      null || false => null,
                      true => _controller.startService(
                          deskNumber: int.parse(_deskNumberEC.text),
                        ),
                    },
                    child: const Text('CHAMAR PRÓXIMO PACIENTE'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _deskNumberEC.dispose();
    super.dispose();
  }
}
