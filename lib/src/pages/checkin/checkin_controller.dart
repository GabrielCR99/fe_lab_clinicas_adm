import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/patient_information_form_model.dart';
import '../../repositories/patient_information_form/patient_information_form_repository.dart';

final class CheckinController extends MessagesControllerMixin {
  final informationForm =
      signal<PatientInformationFormModel?>(null, autoDispose: true);
  final endProcess = signal(false, autoDispose: true);

  final PatientInformationFormRepository _repository;

  CheckinController({required PatientInformationFormRepository repository})
      : _repository = repository;

  Future<void> endCheckin() async {
    if (informationForm() != null) {
      final result = await _repository.updateStatus(
        id: informationForm.value!.id,
        status: PatientInformationFormStatus.beingAttended,
      );

      return switch (result) {
        Left() => showError('Erro ao atualizar status do formulário.'),
        Right() => endProcess.value = true
      };
    } else {
      showError('Formulário não pode ser nulo.');
    }
  }
}
