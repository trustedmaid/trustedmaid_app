import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/maid_service_repository.dart';

class RegisterAgentUseCase implements UseCase<void, RegisterAgentParams> {
  final MaidServiceRepository repository;

  RegisterAgentUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterAgentParams params) async {
    return await repository.registerAgent(
      agentType: params.agentType,
      fullName: params.fullName,
      companyName: params.companyName,
      phone: params.phone,
      alternatePhone: params.alternatePhone,
      email: params.email,
      address: params.address,
      aadharUrl: params.aadharUrl,
      notes: params.notes,
    );
  }
}

class RegisterAgentParams extends Equatable {
  final String agentType;
  final String fullName;
  final String? companyName;
  final String phone;
  final String? alternatePhone;
  final String? email;
  final String? address;
  final String? aadharUrl;
  final String? notes;

  const RegisterAgentParams({
    required this.agentType,
    required this.fullName,
    this.companyName,
    required this.phone,
    this.alternatePhone,
    this.email,
    this.address,
    this.aadharUrl,
    this.notes,
  });

  @override
  List<Object?> get props => [
        agentType,
        fullName,
        companyName,
        phone,
        alternatePhone,
        email,
        address,
        aadharUrl,
        notes,
      ];
}
