import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/entities/maid_service_entity.dart';
import '../../domain/repositories/maid_service_repository.dart';
import '../datasources/maid_service_remote_data_source.dart';

/// Implementation of the domain's [MaidServiceRepository].
class MaidServiceRepositoryImpl implements MaidServiceRepository {
  final MaidServiceRemoteDataSource remoteDataSource;

  MaidServiceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MaidServiceEntity>>> getMaidServices() async {
    try {
      final remoteServices = await remoteDataSource.getMaidServices();
      return Right(remoteServices);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> searchLocations(String query) async {
    try {
      final remoteLocations = await remoteDataSource.searchLocations(query);
      return Right(remoteLocations);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> submitEnquiry({
    required String fullName,
    required String phone,
    required String email,
    required String service,
    required String location,
    required int locationId,
    required String workingHours,
    required String shiftType,
    required String message,
  }) async {
    try {
      await remoteDataSource.submitEnquiry(
        fullName: fullName,
        phone: phone,
        email: email,
        service: service,
        location: location,
        locationId: locationId,
        workingHours: workingHours,
        shiftType: shiftType,
        message: message,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
