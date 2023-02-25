import 'package:furniture/domain/model/models.dart';

class ChairModel extends Chair {
  const ChairModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
  });

  factory ChairModel.fromJson(Map<String, dynamic> json) {
    return ChairModel(
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

//-----------------------------------------

class ChairDetailsModel extends ChairDetails {
  const ChairDetailsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
    required super.rate,
    required super.reviews,
    required super.description,
  });

  factory ChairDetailsModel.fromJson(Map<String, dynamic> json) {
    return ChairDetailsModel(
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

// --------------------------------------------

class CartsModel extends Carts {
  const CartsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
    required super.count,
  });

  factory CartsModel.fromJson(Map<String, dynamic> json) {
    return CartsModel(
      id: (json['id'] as num).toInt(),
      title: json['title'],
      price: (json['price'] as num).toInt(),
      image: json['image'],
      count: (json['count'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'count': count,
    };
  }
}
