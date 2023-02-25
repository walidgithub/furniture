import '../../domain/model/models.dart';

class TableModel extends Dining {
  const TableModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
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

class TableDetailsModel extends TableDetails {
  const TableDetailsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
    required super.rate,
    required super.reviews,
    required super.description,
  });

  factory TableDetailsModel.fromJson(Map<String, dynamic> json) {
    return TableDetailsModel(
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