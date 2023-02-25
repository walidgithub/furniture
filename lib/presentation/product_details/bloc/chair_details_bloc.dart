import 'dart:async';

import 'package:furniture/domain/usecases/chair_usecase/get_chair_details_usecase.dart';

import '../../../core/utils/enums.dart';
import '../../../domain/model/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chair_details_event.dart';
part 'chair_details_state.dart';

class ChairDetailsBloc extends Bloc<ChairDetailsEvent, ChairDetailsState> {
  final GetChairDetailsUseCase getChairDetailsUseCase;

  ChairDetailsBloc(this.getChairDetailsUseCase) : super(const ChairDetailsState()) {
    on<GetChairDetailsEvent>(_getChairDetails);
  }

  FutureOr<void> _getChairDetails(GetChairDetailsEvent event, Emitter<ChairDetailsState> emit) async {
    final result = await getChairDetailsUseCase(event.idChair);

    result.fold(
            (l) => emit(state.copyWith(
            chairDetailsState: RequestState.error, chairDetailsMessage: l.message)),
            (r) => emit(state.copyWith(
          chairDetailsList: r,
          chairDetailsState: RequestState.loaded,
        )));
  }
}
