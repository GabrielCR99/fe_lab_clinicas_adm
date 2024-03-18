import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/patient_information_form_model.dart';
import '../../services/call_next_patient/call_next_patient_service.dart';

final class PreCheckinController extends MessagesControllerMixin {
  final informationForm =
      signal<PatientInformationFormModel?>(null, autoDispose: true);

  final CallNextPatientService _callNextPatientService;

  PreCheckinController({required CallNextPatientService callNextPatientService})
      : _callNextPatientService = callNextPatientService;

  Future<void> callNext() async {
    final result = await _callNextPatientService.execute();

    return switch (result) {
      Left() => showError('Erro ao chamar próximo paciente'),
      Right(value: final form?) => informationForm.value = form,
      Right() => showInfo('Nenhum paciente aguardando'),
    };
  }
}
