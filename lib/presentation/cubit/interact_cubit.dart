import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/presentation/cubit/interact_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/network/network_info.dart';
import '../../domain/model/models.dart';

class InterActCubit extends Cubit<InterActState> {
  InterActCubit(this._networkInfo) : super(InterActInitial());

  static InterActCubit get(context) => BlocProvider.of(context);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // final Completer<GoogleMapController> _controller = Completer();
  //
  // List<Marker> markers = [];

  final NetworkInfo _networkInfo;

  List<FurnitureFavoritesModel> AllItems = [];

  List<FurnitureCartModel> AllCart = [];

  List<FurnitureCartModel> AllUserCart = [];

  bool? ifItemFoundInFavorites = false;

  bool? ifItemFoundInCart = false;

  int countOfSale = 1;

  //---------- Favorites -----------------------------------
  addFavorites(String id, String category, String username) async {
    FurnitureFavoritesModel furnitureFavoritesModel =
        FurnitureFavoritesModel(id: id, category: category, username: username);

    await firestore
        .collection('favorites')
        .doc()
        .set(furnitureFavoritesModel.toMap());

    emit(AddFavoriteState());
  }

  checkFavorites(String id, String category, String username) async {
    AllItems = [];
    var docs = await firestore
        .collection('favorites')
        .where('id', isEqualTo: id)
        .where('category', isEqualTo: category)
        .where('username', isEqualTo: username)
        .get();

    //check if found
    for (var element in docs.docs) {
      AllItems.add(FurnitureFavoritesModel.fromMap(element.data()));
    }

    if (AllItems.isNotEmpty) {
      ifItemFoundInFavorites = true;
    } else {
      ifItemFoundInFavorites = false;
    }

    emit(CheckFavoriteState());
  }

  toggleFavorites(String id, String category, String username) async {
    if (await _networkInfo.isConnected) {
      checkFavorites(id, category, username);

      if (ifItemFoundInFavorites!) {
        await firestore
            .collection('favorites')
            .where('id', isEqualTo: id)
            .where('category', isEqualTo: category)
            .where('username', isEqualTo: username)
            .get()
            .then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
            countOfSale = 1;
          }
        });
        ifItemFoundInFavorites = false;
      } else {
        addFavorites(id, category, username);
        ifItemFoundInFavorites = true;
      }

      emit(ToggleFavoriteState());
    } else {
      emit(NoInternetState());
    }
  }
  //---------- Cart -----------------------------------

  addToCart(String id, String category, String username, String count) async {
    FurnitureCartModel furnitureCartModel = FurnitureCartModel(
        id: id, category: category, username: username, count: count);

    await firestore.collection('carts').doc().set(furnitureCartModel.toMap());

    emit(AddToCartState());
  }

  checkCart(String id, String category, String username) async {
    AllCart = [];
    var docs = await firestore
        .collection('carts')
        .where('id', isEqualTo: id)
        .where('category', isEqualTo: category)
        .where('username', isEqualTo: username)
        .get();

    //check if found
    for (var element in docs.docs) {
      AllCart.add(FurnitureCartModel.fromMap(element.data()));
      countOfSale = int.parse(element.data()['count']);
    }

    if (AllCart.isNotEmpty) {
      ifItemFoundInCart = true;
    } else {
      ifItemFoundInCart = false;
    }

    emit(CheckCartState());
  }

  toggleCart(String id, String category, String username, String count) async {
    if (await _networkInfo.isConnected) {
      checkCart(id, category, username);

      if (ifItemFoundInCart!) {
        await firestore
            .collection('carts')
            .where('id', isEqualTo: id)
            .where('category', isEqualTo: category)
            .where('username', isEqualTo: username)
            .get()
            .then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
            countOfSale = 1;
          }
        });
        ifItemFoundInCart = false;
      } else {
        addToCart(id, category, username, count);
        ifItemFoundInCart = true;
      }

      getCountOfCart('walid barakat');

      emit(ToggleCartState());
    } else {
      emit(NoInternetState());
    }
  }

  //------------------- Count Of Cart

  getCountOfCart(String username) async {
    AllUserCart = [];
    var docs = await firestore
        .collection('carts')
        .where('username', isEqualTo: username)
        .get();

    //check if found
    for (var element in docs.docs) {
      AllUserCart.add(FurnitureCartModel.fromMap(element.data()));
    }

    if (AllUserCart.isNotEmpty) {
      // countOfUserCart = AllUserCart.length;
      emit(UserCartCountState(countOfUserCart: AllUserCart.length));
    } else {
      // countOfUserCart = 0;
      emit(EmptyUserCartCountState(countOfUserCart: 0));
    }
  }

  //------------------- Change count Of Cart

  incrementCount() {
    countOfSale++;
    emit(IncrementState());
  }

  decrementCount() {
    if (countOfSale > 1) {
      countOfSale--;
    }
    emit(DecrementState());
  }
}

