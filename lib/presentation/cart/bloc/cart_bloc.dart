import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:furniture/domain/usecases/get_all_carts_usecase.dart';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import 'package:bloc/bloc.dart';

import '../../../domain/model/models.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetAllCartsUseCase getAllCartsUseCase;

  CartBloc(this.getAllCartsUseCase)
      : super(const CartState()) {
    on<GetAllCartsEvent>(_getAllCarts);
  }

  FutureOr<void> _getAllCarts(
      GetAllCartsEvent event, Emitter<CartState> emit) async {
    final result = await getAllCartsUseCase(const NoParameters());
    result.fold(
            (l) => emit(state.copyWith(
            cartState: RequestState.error, cartMessage: l.message)),
            (r) => emit(state.copyWith(
              cartList: r,
              cartState: RequestState.loaded,
        )));
  }
}
