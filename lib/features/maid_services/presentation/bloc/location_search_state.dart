import 'package:equatable/equatable.dart';
import '../../domain/entities/location_entity.dart';

/// Base state class for the location search module.
abstract class LocationSearchState extends Equatable {
  const LocationSearchState();

  @override
  List<Object?> get props => [];
}

/// Initial state before search query is entered.
class LocationSearchInitial extends LocationSearchState {
  const LocationSearchInitial();
}

/// Loading state active when API is executing.
class LocationSearchLoading extends LocationSearchState {
  const LocationSearchLoading();
}

/// Success state with retrieved location matches.
class LocationSearchSuccess extends LocationSearchState {
  final List<LocationEntity> locations;

  const LocationSearchSuccess(this.locations);

  @override
  List<Object?> get props => [locations];
}

/// Error state in case of network/server exceptions.
class LocationSearchError extends LocationSearchState {
  final String message;

  const LocationSearchError(this.message);

  @override
  List<Object?> get props => [message];
}
