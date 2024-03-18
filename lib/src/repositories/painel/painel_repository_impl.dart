import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import 'painel_repository.dart';

final class PainelRepositoryImpl implements PainelRepository {
  final RestClient restClient;

  const PainelRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, String>> callOnPanel({
    required String password,
    required int attendantDesk,
  }) async {
    try {
      final Response(data: {'id': String id}!) =
          await restClient.auth.post<Map<String, dynamic>>(
        '/painelCheckin',
        data: {
          'password': password,
          'attendant_desk': attendantDesk,
          'time_called': DateTime.now().toIso8601String(),
        },
      );

      return Right(id);
    } on DioException catch (e, s) {
      log('Erro ao chamar paciente no painel', error: e, stackTrace: s);

      return const Left(RepositoryException());
    }
  }
}
