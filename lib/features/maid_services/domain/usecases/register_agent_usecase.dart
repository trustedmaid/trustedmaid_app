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
      companyName: params.companyName,
      fullName: params.fullName,
      phone: params.phone,
      email: params.email,
      address: params.address,
      agentType: params.agentType,
      experienceYears: params.experienceYears,
      helpersCount: params.helpersCount,
      servicesProvided: params.servicesProvided,
    );
  }
}

class RegisterAgentParams extends Equatable {
  final String companyName;
  final String fullName;
  final String phone;
  final String email;
  final String address;
  final String agentType;
  final String experienceYears;
  final String helpersCount;
  final List<String> servicesProvided;

  const RegisterAgentParams({
    required this.companyName,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.address,
    required this.agentType,
    required this.experienceYears,
    required this.helpersCount,
    required this.servicesProvided,
  });

  @override
  List<Object?> get props => [
        companyName,
        fullName,
        phone,
        email,
        address,
        agentType,
        experienceYears,
        helpersCount,
        servicesProvided,
      ];
}
