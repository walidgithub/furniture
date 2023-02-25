part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<Carts> cartList;
  final RequestState cartState;
  final String cartMessage;

  const CartState({
    this.cartList = const [],
    this.cartState = RequestState.loading,
    this.cartMessage = '',
  });

  CartState copyWith({
    List<Carts>? cartList,
    RequestState? cartState,
    String? cartMessage,
  }) {
    return CartState(
      cartList: cartList ?? this.cartList,
      cartState: cartState ?? this.cartState,
      cartMessage: cartMessage ?? this.cartMessage,
    );
  }

  @override
  List<Object?> get props => [cartList, cartState, cartMessage];
}
