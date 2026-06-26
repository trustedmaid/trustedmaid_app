import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/maid_service_repository.dart';

/// UseCase to submit customer salary calculator/inquiry requests to the server.
class SubmitEnquiryUseCase implements UseCase<void, SubmitEnquiryParams> {
  final MaidServiceRepository repository;

  SubmitEnquiryUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitEnquiryParams params) async {
    return await repository.submitEnquiry(
      fullName: params.fullName,
      phone: params.phone,
      email: params.email,
      service: params.service,
      location: params.location,
      locationId: params.locationId,
      workingHours: params.workingHours,
      shiftType: params.shiftType,
      message: params.message,
    );
  }
}

class SubmitEnquiryParams extends Equatable {
  final String fullName;
  final String phone;
  final String email;
  final String service;
  final String location;
  final int locationId;
  final String workingHours;
  final String shiftType;
  final String message;

  const SubmitEnquiryParams({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.service,
    required this.location,
    required this.locationId,
    required this.workingHours,
    required this.shiftType,
    required this.message,
  });

  @override
  List<Object?> get props => [
        fullName,
        phone,
        email,
        service,
        location,
        locationId,
        workingHours,
        shiftType,
        message,
      ];
}
