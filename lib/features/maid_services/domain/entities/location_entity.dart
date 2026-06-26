import 'package:equatable/equatable.dart';

/// Pure domain entity representing a location locality.
class LocationEntity extends Equatable {
  final int id;
  final String displayName;

  const LocationEntity({
    required this.id,
    required this.displayName,
  });

  @override
  List<Object?> get props => [id, displayName];
}
