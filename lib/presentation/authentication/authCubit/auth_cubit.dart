import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/model/models.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._networkInfo) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final NetworkInfo _networkInfo;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseStorage storage = FirebaseStorage.instance;

  GoogleSignIn googleSignIn = GoogleSignIn();

  UserModel userData = UserModel();

  List<UserModel> user = [];

  var snapShot;

  ImagePicker imagePicker = ImagePicker();
  XFile? userImage;

  image(String camera) async {
    if (camera == 'cam') {
      userImage = await imagePicker.pickImage(source: ImageSource.camera);
      return userImage?.readAsBytes();
    } else {
      userImage = await imagePicker.pickImage(source: ImageSource.gallery);
      // return userImage?.readAsBytes();
    }
  }

  registerByEmailAndPassword(String email, String password, String name) async {
    if (await _networkInfo.isConnected) {
      if (userImage != null) {
        try {
          emit(AuthRegisterLoadingState());

          UserCredential credential = await auth
              .createUserWithEmailAndPassword(email: email, password: password);

          userData.id = credential.user!.uid;

          try {
            await storage
                .ref()
                .child("photos/")
                .child('${userData.id}.jpg')
                .putFile(File(userImage!.path));
          } catch (e) {
            emit(AuthErrorLoadingImageState());
          }
        } catch (e) {
          emit(AuthErrorInRegisterState());
        }

        emit(AuthRegisterSucceededState());
      } else {
        emit(AuthErrorLoadingImageState());
      }
    } else {
      emit(NoInternetState());
    }
  }

  login(String email, String password) async {
    if (await _networkInfo.isConnected) {
      try {
        emit(AuthLoginLoadingState());
        await auth.signInWithEmailAndPassword(email: email, password: password);
        emit(AuthLoginState());
      } catch (e) {
        emit(AuthLoginErrorState());
      }
    } else {
      emit(NoInternetState());
    }
  }

  getCurrentUser() async {
    emit(AuthGetCurrentUserLoadingState());
    if (await _networkInfo.isConnected) {
      userData.email = await auth.currentUser!.email;

      userData.photoUrl = await storage
          .ref()
          .child("photos/")
          .child('${await auth.currentUser!.uid}.jpg')
          .getDownloadURL();

      snapShot = await firestore
          .collection('users')
          .where('email', isEqualTo: userData.email)
          .get();

      for (var element in snapShot.docs) {
        user.add(UserModel.fromJson(element.data()));
      }

      emit(AuthGetUserDataState());
    } else {
      emit(NoInternetState());
    }
  }

  userLogout() async {
    if (await _networkInfo.isConnected) {
      await auth.signOut();
      await googleSignIn.signOut();
    } else {
      emit(NoInternetState());
    }
  }

  //-------------- Google -----------------------

  signInByGoogle() async {
    if (await _networkInfo.isConnected) {
      try {
        emit(AuthSignInLoadingState());
        GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;
        AuthCredential userCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        var googleUser = await auth.signInWithCredential(userCredential);

        userData.id = googleUser.user!.uid;
        userData.name = googleSignInAccount.displayName;
        userData.email = googleSignInAccount.email;
        userData.photoUrl = googleSignInAccount.photoUrl;

        await firestore
            .collection("users")
            .doc(userData.id)
            .set(userData.toJson());

        emit(AuthLoginState());
      } catch (e) {
        emit(AuthLoginErrorState());
      }
    } else {
      emit(NoInternetState());
    }
  }
}
