import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/search_locations_usecase.dart';
import 'location_search_event.dart';
import 'location_search_state.dart';

/// Business Logic Component managing locality searching and API invocation states.
class LocationSearchBloc extends Bloc<LocationSearchEvent, LocationSearchState> {
  final SearchLocationsUseCase searchLocationsUseCase;

  LocationSearchBloc({
    required this.searchLocationsUseCase,
  }) : super(const LocationSearchInitial()) {
    on<SearchLocationQueryChanged>(_onSearchLocationQueryChanged);
    on<ClearLocationSearch>(_onClearLocationSearch);
  }

  Future<void> _onSearchLocationQueryChanged(
    SearchLocationQueryChanged event,
    Emitter<LocationSearchState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      emit(const LocationSearchInitial());
      return;
    }

    emit(const LocationSearchLoading());

    final failureOrLocations = await searchLocationsUseCase(query);
    failureOrLocations.fold(
      (failure) => emit(LocationSearchError(failure.message)),
      (locations) => emit(LocationSearchSuccess(locations)),
    );
  }

  void _onClearLocationSearch(
    ClearLocationSearch event,
    Emitter<LocationSearchState> emit,
  ) {
    emit(const LocationSearchInitial());
  }
}
