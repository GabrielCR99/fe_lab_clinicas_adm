import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../models/patient_information_form_model.dart';

abstract interface class PatientInformationFormRepository {
  Future<Either<RepositoryException, PatientInformationFormModel?>>
      callNextToCheckIn();
  Future<Either<RepositoryException, Unit>> updateStatus({
    required String id,
    required PatientInformationFormStatus status,
  });
}
