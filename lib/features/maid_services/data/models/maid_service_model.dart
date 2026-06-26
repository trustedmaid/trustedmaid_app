import '../../domain/entities/maid_service_entity.dart';

/// Data model representing a domestic service, extending the pure domain entity.
class MaidServiceModel extends MaidServiceEntity {
  const MaidServiceModel({
    required super.id,
    required super.title,
    required super.description,
    required super.priceDescription,
    required super.imageUrl,
    required super.rating,
    required super.popularTags,
  });

  /// De-serializes JSON map data into [MaidServiceModel].
  factory MaidServiceModel.fromJson(Map<String, dynamic> json) {
    return MaidServiceModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      priceDescription: json['priceDescription'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      popularTags: List<String>.from(json['popularTags'] ?? []),
    );
  }

  /// Serializes [MaidServiceModel] into standard JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priceDescription': priceDescription,
      'imageUrl': imageUrl,
      'rating': rating,
      'popularTags': popularTags,
    };
  }
}
