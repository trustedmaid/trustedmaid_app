import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/location_entity.dart';
import '../entities/maid_service_entity.dart';

/// Repository interface contract for retrieving domestic helper services.
abstract class MaidServiceRepository {
  /// Fetches lists of available helper services.
  Future<Either<Failure, List<MaidServiceEntity>>> getMaidServices();

  /// Search locations based on query.
  Future<Either<Failure, List<LocationEntity>>> searchLocations(String query);

  /// Submits customer/calculator enquiry.
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
  });
}

