import 'dart:async';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../../domain/model/models.dart';
import '../../../domain/usecases/chair_usecase/get_all_chairs_usecase.dart';
import '../../../domain/usecases/chair_usecase/get_top_chair_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/chair_usecase/search_for_chairs_usecase.dart';

part 'chair_event.dart';
part 'chair_state.dart';

class ChairBloc extends Bloc<ChairEvent, ChairState> {
  final GetTopChairUseCase getTopChairUseCase;
  final GetAllChairsUseCase getAllChairsUseCase;
  final SearchForChairsUseCase searchForChairsUseCase;

  ChairBloc(this.getTopChairUseCase, this.getAllChairsUseCase,
      this.searchForChairsUseCase)
      : super(const ChairState()) {
    on<GetTopChairEvent>(_getTopChair);
    on<GetAllChairsEvent>(_getAllChairs);
    on<SearchForChairsEvent>(_searchForChairs);
  }

  FutureOr<void> _getTopChair(
      GetTopChairEvent event, Emitter<ChairState> emit) async {
    final result = await getTopChairUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            chairState: RequestState.error, chairMessage: l.message)),
        (r) => emit(state.copyWith(
              chairList: r,
              chairState: RequestState.loaded,
            )));
  }

  FutureOr<void> _getAllChairs(
      GetAllChairsEvent event, Emitter<ChairState> emit) async {
    final result = await getAllChairsUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            chairState: RequestState.error, chairMessage: l.message)),
        (r) => emit(state.copyWith(
              chairList: r,
              chairState: RequestState.loaded,
            )));
  }

  FutureOr<void> _searchForChairs(
      SearchForChairsEvent event, Emitter<ChairState> emit) async {
    final result = await searchForChairsUseCase(event.searchTitle);

    result.fold(
        (l) => emit(state.copyWith(
            chairState: RequestState.error, chairMessage: l.message)),
        (r) => emit(state.copyWith(
              chairList: r,
              chairState: RequestState.loaded,
            )));
  }
}
