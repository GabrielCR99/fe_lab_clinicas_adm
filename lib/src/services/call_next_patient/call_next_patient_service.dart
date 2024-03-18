import 'dart:developer';

import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../models/patient_information_form_model.dart';
import '../../repositories/attendant_desk_assignment/attendant_desk_assignment_repository.dart';
import '../../repositories/painel/painel_repository.dart';
import '../../repositories/patient_information_form/patient_information_form_repository.dart';

final class CallNextPatientService {
  final PatientInformationFormRepository _patientInformationFormRepository;
  final AttendantDeskAssignmentRepository _attendantDeskAssignmentRepository;
  final PainelRepository _painelRepository;

  const CallNextPatientService({
    required PatientInformationFormRepository patientInformationFormRepository,
    required AttendantDeskAssignmentRepository
        attendantDeskAssignmentRepository,
    required PainelRepository painelRepository,
  })  : _patientInformationFormRepository = patientInformationFormRepository,
        _attendantDeskAssignmentRepository = attendantDeskAssignmentRepository,
        _painelRepository = painelRepository;

  Future<Either<RepositoryException, PatientInformationFormModel?>>
      execute() async {
    final result = await _patientInformationFormRepository.callNextToCheckIn();

    switch (result) {
      case Left(:final value):
        return Left(value);
      case Right(:final value?):
        return updatePanel(value);
      case Right():
        return const Right(null);
    }
  }

  Future<Either<RepositoryException, PatientInformationFormModel?>> updatePanel(
    PatientInformationFormModel form,
  ) async {
    final deskResult =
        await _attendantDeskAssignmentRepository.getDeskAssignment();

    switch (deskResult) {
      case Left(:final value):
        return Left(value);
      case Right(:final value):
        final painelResult = await _painelRepository.callOnPanel(
          password: form.password,
          attendantDesk: value,
        );
        switch (painelResult) {
          case Left(:final value):
            const errorMessage = 'Erro ao chamar paciente no painel';
            log(
              errorMessage,
              error: value,
              stackTrace: StackTrace.fromString(errorMessage),
            );
            return Right(form);
          case Right():
            return Right(form);
        }
    }
  }
}
