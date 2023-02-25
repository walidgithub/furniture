abstract class InterActState{}

class InterActInitial extends InterActState {}

class AddFavoriteState extends InterActState {}

class CheckFavoriteState extends InterActState {}

class ToggleFavoriteState extends InterActState {}

class AddToCartState extends InterActState {}

class CheckCartState extends InterActState {}

class ToggleCartState extends InterActState {}

class UserCartCountState extends InterActState {
  int countOfUserCart;

  UserCartCountState({
    required this.countOfUserCart,
  });
}
class EmptyUserCartCountState extends InterActState {
  int countOfUserCart;

  EmptyUserCartCountState({
    required this.countOfUserCart,
  });
}

class IncrementState extends InterActState {}

class DecrementState extends InterActState {}

class NoInternetState extends InterActState {}