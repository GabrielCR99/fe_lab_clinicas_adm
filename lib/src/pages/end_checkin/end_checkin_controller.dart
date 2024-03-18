import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/patient_information_form_model.dart';
import '../../services/call_next_patient/call_next_patient_service.dart';

final class EndCheckinController with MessagesControllerMixin {
  final informationForm = signal<PatientInformationFormModel?>(null);
  final CallNextPatientService _callNextPatientService;

  EndCheckinController({required CallNextPatientService callNextPatientService})
      : _callNextPatientService = callNextPatientService;

  Future<void> callNextPatient() async {
    final result = await _callNextPatientService.execute();

    return switch (result) {
      Left() => showError('Erro ao chamar próximo paciente'),
      Right(value: final form?) => informationForm.value = form,
      _ => showInfo('Nenhum paciente na fila para ser chamado'),
    };
  }
}
