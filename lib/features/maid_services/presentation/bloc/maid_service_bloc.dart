import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_maid_services_usecase.dart';
import 'maid_service_event.dart';
import 'maid_service_state.dart';

/// Business Logic Component managing state cycles of the domestic help services module.
class MaidServiceBloc extends Bloc<MaidServiceEvent, MaidServiceState> {
  final GetMaidServicesUseCase getMaidServicesUseCase;

  MaidServiceBloc({
    required this.getMaidServicesUseCase,
  }) : super(const MaidServiceInitial()) {
    on<GetMaidServicesEvent>(_onGetMaidServices);
  }

  Future<void> _onGetMaidServices(
    GetMaidServicesEvent event,
    Emitter<MaidServiceState> emit,
  ) async {
    emit(const MaidServiceLoading());
    final failureOrServices = await getMaidServicesUseCase(const NoParams());
    failureOrServices.fold(
      (failure) => emit(MaidServiceError(failure.message)),
      (services) => emit(MaidServiceLoaded(services)),
    );
  }
}
