import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../models/patient_information_form_model.dart';
import './patient_information_form_repository.dart';

final class PatientInformationFormRepositoryImpl
    implements PatientInformationFormRepository {
  final RestClient restClient;

  const PatientInformationFormRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, PatientInformationFormModel?>>
      callNextToCheckIn() async {
    final Response(:data) = await restClient.auth.get<List<Object?>>(
      '/patientInformationForm',
      queryParameters: {
        'status': PatientInformationFormStatus.waiting.id,
        'page': 1,
        'limit': 1,
      },
    );

    if (data?.isEmpty ?? true) {
      return const Right(null);
    }

    final formData = data!.first! as Map<String, dynamic>;
    final updateStatusResult = await updateStatus(
      id: formData['id'] as String,
      status: PatientInformationFormStatus.checkin,
    );

    switch (updateStatusResult) {
      case Left(:final value):
        return Left(value);
      case Right():
        formData['status'] = PatientInformationFormStatus.checkin.id;
        formData['patient'] =
            await _getPatient(formData['patient_id'] as String);

        return Right(PatientInformationFormModel.fromJson(formData));
    }
  }

  @override
  Future<Either<RepositoryException, Unit>> updateStatus({
    required String id,
    required PatientInformationFormStatus status,
  }) async {
    try {
      await restClient.auth.put<void>(
        '/patientInformationForm/$id',
        data: {'status': status.id},
      );

      return const Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao atualizar status do formulário', error: e, stackTrace: s);

      return const Left(RepositoryException());
    }
  }

  Future<Map<String, dynamic>> _getPatient(String id) async {
    final Response(:data!) =
        await restClient.auth.get<Map<String, dynamic>>('/patients/$id');

    return data;
  }
}
