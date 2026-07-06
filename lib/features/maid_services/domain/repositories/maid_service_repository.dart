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

  /// Submits partial customer enquiry (phone lead).
  Future<Either<Failure, void>> submitPartialEnquiry({
    required String phone,
    String? fullName,
    String? email,
    String? service,
    String? location,
    int? locationId,
    String? workingHours,
    String? shiftType,
    String? message,
  });

  /// Registers a new agent.
  Future<Either<Failure, void>> registerAgent({
    required String agentType,
    required String fullName,
    required String? companyName,
    required String phone,
    required String? alternatePhone,
    required String? email,
    required String? address,
    required String? aadharUrl,
    required String? notes,
  });

  /// Uploads a public file for agents.
  Future<Either<Failure, String>> uploadPublicFile(String filePath);

  /// Registers a new maid.
  Future<Either<Failure, void>> registerMaid({
    required String fullName,
    required String gender,
    required String age,
    required String phone,
    required String alternatePhone,
    required String email,
    required String dob,
    required String maritalStatus,
    required String religion,
    required String? agentId,
    required int? currentLocationId,
    required List<int> preferredLocationIds,
    required String expectedSalary,
    required String workingHours,
    required List<String> languages,
    required bool aadhaarVerified,
    required bool policeVerified,
    required String? photoPath,
    required String? aadhaarPath,
    required List<Map<String, dynamic>> services,
  });
}

