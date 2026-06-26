import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/location_entity.dart';
import '../repositories/maid_service_repository.dart';

/// Concrete UseCase to search available localities based on a string query.
class SearchLocationsUseCase implements UseCase<List<LocationEntity>, String> {
  final MaidServiceRepository repository;

  SearchLocationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<LocationEntity>>> call(String params) async {
    return await repository.searchLocations(params);
  }
}
