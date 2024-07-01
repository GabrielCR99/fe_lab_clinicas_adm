import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/patient_address_model.dart';
import '../../models/patient_information_form_model.dart';
import '../../models/patient_model.dart';
import '../../shared/data_item.dart';
import 'checkin_controller.dart';
import 'widgets/checkin_image_link.dart';

final class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

final class _CheckinPageState extends State<CheckinPage> {
  final _controller = Injector.get<CheckinController>();

  @override
  void initState() {
    super.initState();
    context.messageListener(_controller);
    effect(() {
      if (_controller.endProcess()) {
        Navigator.of(context).pushReplacementNamed<void, void>('/end-checkin');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const bottomPadding = EdgeInsets.only(bottom: 24);
    final PatientInformationFormModel(
      :password,
      patient: PatientModel(
        :name,
        :phoneNumber,
        :document,
        :email,
        :guardian,
        :guardianIdentificationNumber,
        address: PatientAddressModel(
          :cep,
          :streetAddress,
          :number,
          :addressComplement,
          :state,
          :city,
          :district,
        ),
      ),
      :medicalOrders,
      :healthInsuranceCard,
    ) = _controller.informationForm.watch(context)!;

    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border.fromBorderSide(BorderSide(color: orangeColor)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            width: MediaQuery.sizeOf(context).width * 0.5,
            margin: const EdgeInsets.only(top: 56),
            child: Column(
              children: [
                Image.asset('assets/images/patient_avatar.png'),
                const SizedBox(height: 16),
                const Text('A senha chamada foi', style: titleSmallStyle),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  decoration: const BoxDecoration(
                    color: orangeColor,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  width: 218,
                  child: Text(
                    password,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: lightOrangeColor,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  width: double.infinity,
                  child: Text(
                    'Cadastro',
                    style: subtitleSmallStyle.copyWith(
                      color: orangeColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                DataItem(
                  label: 'Nome Paciente',
                  value: name,
                  padding: bottomPadding,
                ),
                DataItem(
                  label: 'Email',
                  value: email,
                  padding: bottomPadding,
                ),
                DataItem(
                  label: 'Telefone de contato',
                  value: phoneNumber,
                  padding: bottomPadding,
                ),
                DataItem(
                  label: 'CPF',
                  value: document,
                  padding: bottomPadding,
                ),
                DataItem(
                  label: 'CEP',
                  value: cep,
                  padding: bottomPadding,
                ),
                DataItem(
                  label: 'Endereço',
                  value: '$streetAddress, $number $addressComplement, '
                      '$district, $city - '
                      '$state',
                  padding: bottomPadding,
                ),
                DataItem(
                  label: 'Responsável',
                  value: guardian,
                  padding: bottomPadding,
                ),
                DataItem(
                  label: 'Documento de identificação',
                  value: guardianIdentificationNumber,
                  padding: bottomPadding,
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: lightOrangeColor,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  width: double.infinity,
                  child: Text(
                    'Validar Imagens Exames',
                    style: subtitleSmallStyle.copyWith(
                      color: orangeColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CheckinImageLink(
                      label: 'Carteirinha',
                      image: healthInsuranceCard,
                    ),
                    Column(
                      children: [
                        for (final (index, medicalOrder)
                            in medicalOrders.indexed)
                          CheckinImageLink(
                            label: 'Pedido médico ${index + 1} ',
                            image: medicalOrder,
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _controller.endCheckin,
                    child: const Text('FINALIZAR ATENDIMENTO'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
