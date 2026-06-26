import 'package:equatable/equatable.dart';
import '../../domain/entities/maid_service_entity.dart';

/// Base state class emitted by the [MaidServiceBloc].
abstract class MaidServiceState extends Equatable {
  const MaidServiceState();

  @override
  List<Object?> get props => [];
}

/// Initial state prior to any events being handled.
class MaidServiceInitial extends MaidServiceState {
  const MaidServiceInitial();
}

/// Loading state emitted while fetching details from the database.
class MaidServiceLoading extends MaidServiceState {
  const MaidServiceLoading();
}

/// Loaded state containing the retrieved maid services.
class MaidServiceLoaded extends MaidServiceState {
  final List<MaidServiceEntity> services;

  const MaidServiceLoaded(this.services);

  @override
  List<Object?> get props => [services];
}

/// Error state emitted in case of exceptions.
class MaidServiceError extends MaidServiceState {
  final String message;

  const MaidServiceError(this.message);

  @override
  List<Object?> get props => [message];
}
