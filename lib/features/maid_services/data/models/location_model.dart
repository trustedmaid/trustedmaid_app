import '../../domain/entities/location_entity.dart';

/// Data model representing a location locality, extending the pure domain entity.
class LocationModel extends LocationEntity {
  const LocationModel({
    required super.id,
    required super.displayName,
  });

  /// De-serializes JSON map data into [LocationModel].
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as int,
      displayName: json['display_name'] as String,
    );
  }

  /// Serializes [LocationModel] into a standard JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'display_name': displayName,
    };
  }
}
