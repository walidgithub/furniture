import '../../domain/model/models.dart';

class SofaModel extends Sofa {
  const SofaModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
  });

  factory SofaModel.fromJson(Map<String, dynamic> json) {
    return SofaModel(
      id: (json['id'] as num).toInt(),
      title: json['title'],
      price: (json['price'] as num).toInt(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
    };
  }
}

class SofaDetailsModel extends SofaDetails {
  const SofaDetailsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
    required super.rate,
    required super.reviews,
    required super.description,
  });

  factory SofaDetailsModel.fromJson(Map<String, dynamic> json) {
    return SofaDetailsModel(
      id: (json['id'] as num).toInt(),
      title: json['title'],
      price: (json['price'] as num).toInt(),
      image: json['image'],
      rate: json['rate'],
      reviews: json['reviews'],
      description: json['description'],
    );
  }
}