import 'package:lab_clinicas_core/lab_clinicas_core.dart';

abstract interface class PainelRepository {
  Future<Either<RepositoryException, String>> callOnPanel({
    required String password,
    required int attendantDesk,
  });
}
