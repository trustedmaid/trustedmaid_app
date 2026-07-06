import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/maid_service_repository.dart';

/// UseCase to submit partial customer salary calculator/inquiry requests (phone capture) to the server.
class SubmitPartialEnquiryUseCase implements UseCase<void, SubmitPartialEnquiryParams> {
  final MaidServiceRepository repository;

  SubmitPartialEnquiryUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitPartialEnquiryParams params) async {
    return await repository.submitPartialEnquiry(
      phone: params.phone,
      fullName: params.fullName,
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

class SubmitPartialEnquiryParams extends Equatable {
  final String phone;
  final String? fullName;
  final String? email;
  final String? service;
  final String? location;
  final int? locationId;
  final String? workingHours;
  final String? shiftType;
  final String? message;

  const SubmitPartialEnquiryParams({
    required this.phone,
    this.fullName,
    this.email,
    this.service,
    this.location,
    this.locationId,
    this.workingHours,
    this.shiftType,
    this.message,
  });

  @override
  List<Object?> get props => [
        phone,
        fullName,
        email,
        service,
        location,
        locationId,
        workingHours,
        shiftType,
        message,
      ];
}
