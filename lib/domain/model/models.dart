import 'package:equatable/equatable.dart';

class Chair extends Equatable {
  final int id;
  final String title;
  final int price;
  final String image;

  const Chair({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  @override
  List<Object?> get props => [id, title, price, image];
}

class Dining extends Equatable {
  final int id;
  final String title;
  final int price;
  final String image;

  const Dining({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  @override
  List<Object?> get props => [id, title, price, image];
}

class Sofa extends Equatable {
  final int id;
  final String title;
  final int price;
  final String image;

  const Sofa({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  @override
  List<Object?> get props => [id, title, price, image];
}

class Cupboard extends Equatable {
  final int id;
  final String title;
  final int price;
  final String image;

  const Cupboard({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  @override
  List<Object?> get props => [id, title, price, image];
}

//----------------------------------------------------

class ChairDetails extends Equatable {
  final int id;
  final String title;
  final int price;
  final String image;
  final String rate;
  final String reviews;
  final String description;

  const ChairDetails({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.rate,
    required this.reviews,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        image,
        rate,
        reviews,
        description,
      ];
}

//----------------------------------------------------

class SofaDetails extends Equatable {
  final int id;
  final String title;
  final int price;
  final String image;
  final String rate;
  final String reviews;
  final String description;

  const SofaDetails({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.rate,
    required this.reviews,
    required this.description,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    price,
    image,
    rate,
    reviews,
    description,
  ];
}

//----------------------------------------------------

class TableDetails extends Equatable {
  final int id;
  final String title;
  final int price;
  final String image;
  final String rate;
  final String reviews;
  final String description;

  const TableDetails({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.rate,
    required this.reviews,
    required this.description,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    price,
    image,
    rate,
    reviews,
    description,
  ];
}

//----------------------------------------------------

class CupboardDetails extends Equatable {
  final int id;
  final String title;
  final int price;
  final String image;
  final String rate;
  final String reviews;
  final String description;

  const CupboardDetails({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.rate,
    required this.reviews,
    required this.description,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    price,
    image,
    rate,
    reviews,
    description,
  ];
}

// ----------------------- FavoritesModel -------------------------

class FurnitureFavoritesModel {
  String? id, category, username;

  FurnitureFavoritesModel({this.id, this.category, this.username});

  static FurnitureFavoritesModel fromMap(Map<String, dynamic> map) {
    FurnitureFavoritesModel furnitureFavoritesModel = FurnitureFavoritesModel(
        id: map['id'], category: map['category'], username: map['username']);

    return furnitureFavoritesModel;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'category': category,
      'username': username
    };
    return map;
  }
}

// ----------------------- CartModel -------------------------

class FurnitureCartModel {
  String? id, category, username, count;

  FurnitureCartModel({this.id, this.category, this.username, this.count});

  static FurnitureCartModel fromMap(Map<String, dynamic> map) {
    FurnitureCartModel furnitureCartModel = FurnitureCartModel(
        id: map['id'],
        category: map['category'],
        username: map['username'],
        count: map['count']);

    return furnitureCartModel;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'category': category,
      'username': username,
      'count': count
    };
    return map;
  }
}

// ---------------------- All Carts --------------------------

class Carts extends Equatable {
  final int id;
  final String title;
  final int price;
  final String image;
  final int count;

  const Carts({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.count,
  });

  @override
  List<Object?> get props => [id, title, price, image, count];
}

// ------------------- Users -------------------------
class UserModel {
  String? name, id, email, password, photoUrl;

  UserModel({this.name, this.email, this.id, this.password, this.photoUrl});

  static UserModel fromJson(Map<String, dynamic> map) {
    UserModel user = UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      photoUrl: map['photoUrl'],
    );
    return user;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "photoUrl": photoUrl,
    };
    return json;
  }
}

// -------------------- Notifications ----------------------

class NotificationModel {
  int? _id;
  String? _notificationText;
  String? _userName;

  NotificationModel(dynamic obj) {
    _id = obj['id'];
    _notificationText = obj['notificationText'];
    _userName = obj['userName'];
  }

  NotificationModel.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _notificationText = data['notificationText'];
    _userName = data['userName'];
  }

  Map<String, dynamic> toMap() => {
        "id": _id,
        "notificationText": _notificationText,
        "userName": _userName,
      };

  int get id => _id!;
  String get notificationText => _notificationText!;
  String get userName => _userName!;
}
