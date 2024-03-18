import 'package:lab_clinicas_core/lab_clinicas_core.dart';

abstract interface class AttendantDeskAssignmentRepository {
  Future<Either<RepositoryException, Unit>> startService({
    required int deskNumber,
  });
  Future<Either<RepositoryException, int>> getDeskAssignment();
}
