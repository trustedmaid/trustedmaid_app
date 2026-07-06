import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../network/dio_client.dart';
import '../../features/maid_services/data/datasources/maid_service_remote_data_source.dart';
import '../../features/maid_services/data/repositories/maid_service_repository_impl.dart';
import '../../features/maid_services/domain/repositories/maid_service_repository.dart';
import '../../features/maid_services/domain/usecases/get_maid_services_usecase.dart';
import '../../features/maid_services/domain/usecases/search_locations_usecase.dart';
import '../../features/maid_services/domain/usecases/submit_enquiry_usecase.dart';
import '../../features/maid_services/domain/usecases/submit_partial_enquiry_usecase.dart';
import '../../features/maid_services/domain/usecases/register_agent_usecase.dart';
import '../../features/maid_services/domain/usecases/register_maid_usecase.dart';
import '../../features/maid_services/domain/usecases/upload_public_file_usecase.dart';
import '../../features/maid_services/presentation/bloc/location_search_bloc.dart';
import '../../features/maid_services/presentation/bloc/maid_service_bloc.dart';

final sl = GetIt.instance;

/// Initializes dependency injection for core components and features.
Future<void> init() async {
  // =========================================================================
  // Features - Maid Services
  // =========================================================================
  
  // BLoCs (Factory: creates a new instance every time requested)
  sl.registerFactory(
    () => MaidServiceBloc(
      getMaidServicesUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => LocationSearchBloc(
      searchLocationsUseCase: sl(),
    ),
  );

  // Use Cases (Lazy Singleton: instantiation happens on demand)
  sl.registerLazySingleton(() => GetMaidServicesUseCase(sl()));
  sl.registerLazySingleton(() => SearchLocationsUseCase(sl()));
  sl.registerLazySingleton(() => SubmitEnquiryUseCase(sl()));
  sl.registerLazySingleton(() => SubmitPartialEnquiryUseCase(sl()));
  sl.registerLazySingleton(() => RegisterAgentUseCase(sl()));
  sl.registerLazySingleton(() => RegisterMaidUseCase(sl()));
  sl.registerLazySingleton(() => UploadPublicFileUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<MaidServiceRepository>(
    () => MaidServiceRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<MaidServiceRemoteDataSource>(
    () => MaidServiceRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // =========================================================================
  // Core
  // =========================================================================
  sl.registerLazySingleton(() => DioClient(sl()));

  // =========================================================================
  // External
  // =========================================================================
  sl.registerLazySingleton(() => Dio());
}
