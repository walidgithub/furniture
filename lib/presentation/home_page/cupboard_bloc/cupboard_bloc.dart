import 'dart:async';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../../domain/model/models.dart';
import '../../../domain/usecases/cupboard_usecase/get_all_cupboards_usecase.dart';
import '../../../domain/usecases/cupboard_usecase/get_top_cupboard_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/cupboard_usecase/search_for_cupboards_usecase.dart';

part 'cupboard_event.dart';
part 'cupboard_state.dart';

class CupboardBloc extends Bloc<CupboardEvent, CupboardState> {
  final GetTopCupboardUseCase getTopCupboardUseCase;
  final GetAllCupboardsUseCase getAllCupboardsUseCase;
  final SearchForCupboardsUseCase searchForCupboardsUseCase;

  CupboardBloc(this.getTopCupboardUseCase, this.getAllCupboardsUseCase,
      this.searchForCupboardsUseCase)
      : super(const CupboardState()) {
    on<GetTopCupboardEvent>(_getTopCupboard);
    on<GetAllCupboardsEvent>(_getAllCupboards);
    on<SearchForCupboardsEvent>(_searchForCupboards);
  }

  FutureOr<void> _getTopCupboard(
      GetTopCupboardEvent event, Emitter<CupboardState> emit) async {
    final result = await getTopCupboardUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            cupboardState: RequestState.error, cupboardMessage: l.message)),
        (r) => emit(state.copyWith(
              cupboardList: r,
              cupboardState: RequestState.loaded,
            )));
  }

  FutureOr<void> _getAllCupboards(
      GetAllCupboardsEvent event, Emitter<CupboardState> emit) async {
    final result = await getAllCupboardsUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            cupboardState: RequestState.error, cupboardMessage: l.message)),
        (r) => emit(state.copyWith(
              cupboardList: r,
              cupboardState: RequestState.loaded,
            )));
  }

  FutureOr<void> _searchForCupboards(
      SearchForCupboardsEvent event, Emitter<CupboardState> emit) async {
    final result = await searchForCupboardsUseCase(event.searchTitle);

    result.fold(
        (l) => emit(state.copyWith(
            cupboardState: RequestState.error, cupboardMessage: l.message)),
        (r) => emit(state.copyWith(
              cupboardList: r,
              cupboardState: RequestState.loaded,
            )));
  }
}
