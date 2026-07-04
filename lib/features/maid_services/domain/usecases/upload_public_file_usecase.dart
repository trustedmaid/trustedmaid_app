import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/maid_service_repository.dart';

class UploadPublicFileUseCase implements UseCase<String, String> {
  final MaidServiceRepository repository;

  UploadPublicFileUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(String filePath) async {
    return await repository.uploadPublicFile(filePath);
  }
}
