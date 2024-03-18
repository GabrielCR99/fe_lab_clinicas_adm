import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import './attendant_desk_assignment_repository.dart';

final class AttendantDeskAssignmentRepositoryImpl
    implements AttendantDeskAssignmentRepository {
  final RestClient restClient;

  const AttendantDeskAssignmentRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, Unit>> startService({
    required int deskNumber,
  }) async {
    final result = await _clearDeskByUser();

    switch (result) {
      case Left(:final value):
        return Left(value);
      case Right():
        await restClient.auth.post<void>(
          '/attendantDeskAssignment',
          data: {
            'user_id': '#userAuthRef',
            'desk_number': deskNumber,
            'date_created': DateTime.now().toIso8601String(),
            'status': 'Available',
          },
        );

        return const Right(unit);
    }
  }

  Future<Either<RepositoryException, Unit>> _clearDeskByUser() async {
    try {
      final desk = await _getDeskByUser();

      if (desk != null) {
        await restClient.auth
            .delete<void>('/attendantDeskAssignment/${desk.id}');
      }

      return const Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao deletar número do guichê', error: e, stackTrace: s);

      return const Left(RepositoryException());
    }
  }

  Future<({String id, int deskNumber})?> _getDeskByUser() async {
    final Response(:data) = await restClient.auth.get<List<Object?>>(
      '/attendantDeskAssignment',
      queryParameters: {'user_id': '#userAuthRef'},
    );

    if (data
        case List(
          isNotEmpty: true,
          first: {'id': final String id, 'desk_number': final int deskNumber},
        )) {
      return (id: id, deskNumber: deskNumber);
    }

    return null;
  }

  @override
  Future<Either<RepositoryException, int>> getDeskAssignment() async {
    try {
      final Response(data: List(first: data)!) =
          await restClient.auth.get<List<Object?>>(
        '/attendantDeskAssignment',
        queryParameters: {'user_id': '#userAuthRef'},
      );

      return Right((data! as Map)['desk_number'] as int);
    } on DioException catch (e, s) {
      log('Erro ao buscar número do guichê', error: e, stackTrace: s);

      return const Left(RepositoryException());
    }
  }
}
