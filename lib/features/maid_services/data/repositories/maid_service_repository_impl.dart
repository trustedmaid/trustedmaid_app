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

  @override
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
  }) async {
    try {
      await remoteDataSource.submitPartialEnquiry(
        phone: phone,
        fullName: fullName,
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

  @override
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
  }) async {
    try {
      await remoteDataSource.registerAgent(
        agentType: agentType,
        fullName: fullName,
        companyName: companyName,
        phone: phone,
        alternatePhone: alternatePhone,
        email: email,
        address: address,
        aadharUrl: aadharUrl,
        notes: notes,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadPublicFile(String filePath) async {
    try {
      final url = await remoteDataSource.uploadPublicFile(filePath);
      return Right(url);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
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
  }) async {
    try {
      await remoteDataSource.registerMaid(
        fullName: fullName,
        gender: gender,
        age: age,
        phone: phone,
        alternatePhone: alternatePhone,
        email: email,
        dob: dob,
        maritalStatus: maritalStatus,
        religion: religion,
        agentId: agentId,
        currentLocationId: currentLocationId,
        preferredLocationIds: preferredLocationIds,
        expectedSalary: expectedSalary,
        workingHours: workingHours,
        languages: languages,
        aadhaarVerified: aadhaarVerified,
        policeVerified: policeVerified,
        photoPath: photoPath,
        aadhaarPath: aadhaarPath,
        services: services,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
