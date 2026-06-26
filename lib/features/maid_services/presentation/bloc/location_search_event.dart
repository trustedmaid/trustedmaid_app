import 'package:equatable/equatable.dart';

/// Base event class for the location search module.
abstract class LocationSearchEvent extends Equatable {
  const LocationSearchEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched when the user types in the search query.
class SearchLocationQueryChanged extends LocationSearchEvent {
  final String query;

  const SearchLocationQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

/// Dispatched to clear previous search results.
class ClearLocationSearch extends LocationSearchEvent {
  const ClearLocationSearch();
}
