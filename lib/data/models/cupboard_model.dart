import '../../domain/model/models.dart';

class CupboardModel extends Cupboard {
  const CupboardModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
  });

  factory CupboardModel.fromJson(Map<String, dynamic> json) {
    return CupboardModel(
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

class CupboardDetailsModel extends CupboardDetails {
  const CupboardDetailsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
    required super.rate,
    required super.reviews,
    required super.description,
  });

  factory CupboardDetailsModel.fromJson(Map<String, dynamic> json) {
    return CupboardDetailsModel(
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