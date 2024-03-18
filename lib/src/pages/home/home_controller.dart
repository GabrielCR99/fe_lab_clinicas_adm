import 'package:asyncstate/asyncstate.dart' as async_state show AsyncState;
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/patient_information_form_model.dart';
import '../../repositories/attendant_desk_assignment/attendant_desk_assignment_repository.dart';
import '../../services/call_next_patient/call_next_patient_service.dart';

final class HomeController with MessagesControllerMixin {
  final AttendantDeskAssignmentRepository _attendantDeskAssignmentRepository;
  final CallNextPatientService _callNextPatientService;

  final _informationForm =
      signal<PatientInformationFormModel?>(null, autoDispose: true);
  PatientInformationFormModel? get informationForm => _informationForm();

  HomeController({
    required AttendantDeskAssignmentRepository
        attendantDeskAssignmentRepository,
    required CallNextPatientService callNextPatientService,
  })  : _attendantDeskAssignmentRepository = attendantDeskAssignmentRepository,
        _callNextPatientService = callNextPatientService;

  Future<void> startService({required int deskNumber}) async {
    async_state.AsyncState.show();
    final result = await _attendantDeskAssignmentRepository.startService(
      deskNumber: deskNumber,
    );

    switch (result) {
      case Left():
        async_state.AsyncState.hide();
        showError('Erro ao iniciar guichê');

      case Right():
        final resultNextPatient = await _callNextPatientService.execute();

        switch (resultNextPatient) {
          case Left():
            showError('Erro ao chamar próximo paciente');

          case Right(value: final form?):
            async_state.AsyncState.hide();
            _informationForm.value = form;

          case Right():
            async_state.AsyncState.hide();
            showInfo('Nenhum paciente aguardando, pode ir tomar um cafezinho');
        }
    }
  }
}
