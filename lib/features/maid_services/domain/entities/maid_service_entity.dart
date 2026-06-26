import 'package:equatable/equatable.dart';

/// Pure domain entity representing a Maid Service offered by Trusted Maid.
class MaidServiceEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String priceDescription;
  final String imageUrl;
  final double rating;
  final List<String> popularTags;

  const MaidServiceEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.priceDescription,
    required this.imageUrl,
    required this.rating,
    required this.popularTags,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        priceDescription,
        imageUrl,
        rating,
        popularTags,
      ];
}
