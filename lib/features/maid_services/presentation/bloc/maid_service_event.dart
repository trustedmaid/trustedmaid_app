import 'package:equatable/equatable.dart';

/// Base event class for the maid services module.
abstract class MaidServiceEvent extends Equatable {
  const MaidServiceEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched to load list of available maid services.
class GetMaidServicesEvent extends MaidServiceEvent {
  const GetMaidServicesEvent();
}
