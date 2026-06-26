import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/maid_service_entity.dart';
import '../repositories/maid_service_repository.dart';

/// Concrete UseCase to retrieve lists of helper services.
class GetMaidServicesUseCase implements UseCase<List<MaidServiceEntity>, NoParams> {
  final MaidServiceRepository repository;

  GetMaidServicesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MaidServiceEntity>>> call(NoParams params) async {
    return await repository.getMaidServices();
  }
}
