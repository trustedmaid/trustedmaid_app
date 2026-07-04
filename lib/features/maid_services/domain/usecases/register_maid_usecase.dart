import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/maid_service_repository.dart';

class RegisterMaidUseCase implements UseCase<void, RegisterMaidParams> {
  final MaidServiceRepository repository;

  RegisterMaidUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterMaidParams params) async {
    return await repository.registerMaid(
      fullName: params.fullName,
      gender: params.gender,
      age: params.age,
      phone: params.phone,
      alternatePhone: params.alternatePhone,
      email: params.email,
      dob: params.dob,
      maritalStatus: params.maritalStatus,
      religion: params.religion,
      agentId: params.agentId,
      currentLocationId: params.currentLocationId,
      preferredLocationIds: params.preferredLocationIds,
      expectedSalary: params.expectedSalary,
      workingHours: params.workingHours,
      languages: params.languages,
      aadhaarVerified: params.aadhaarVerified,
      policeVerified: params.policeVerified,
      photoPath: params.photoPath,
      aadhaarPath: params.aadhaarPath,
      services: params.services,
    );
  }
}

class RegisterMaidParams extends Equatable {
  final String fullName;
  final String gender;
  final String age;
  final String phone;
  final String alternatePhone;
  final String email;
  final String dob;
  final String maritalStatus;
  final String religion;
  final String? agentId;
  final int? currentLocationId;
  final List<int> preferredLocationIds;
  final String expectedSalary;
  final String workingHours;
  final List<String> languages;
  final bool aadhaarVerified;
  final bool policeVerified;
  final String? photoPath;
  final String? aadhaarPath;
  final List<Map<String, dynamic>> services;

  const RegisterMaidParams({
    required this.fullName,
    required this.gender,
    required this.age,
    required this.phone,
    required this.alternatePhone,
    required this.email,
    required this.dob,
    required this.maritalStatus,
    required this.religion,
    this.agentId,
    this.currentLocationId,
    required this.preferredLocationIds,
    required this.expectedSalary,
    required this.workingHours,
    required this.languages,
    required this.aadhaarVerified,
    required this.policeVerified,
    this.photoPath,
    this.aadhaarPath,
    required this.services,
  });

  @override
  List<Object?> get props => [
        fullName,
        gender,
        age,
        phone,
        alternatePhone,
        email,
        dob,
        maritalStatus,
        religion,
        agentId,
        currentLocationId,
        preferredLocationIds,
        expectedSalary,
        workingHours,
        languages,
        aadhaarVerified,
        policeVerified,
        photoPath,
        aadhaarPath,
        services,
      ];
}
