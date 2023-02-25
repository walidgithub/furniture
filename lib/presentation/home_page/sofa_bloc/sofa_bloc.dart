import 'dart:async';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../../domain/model/models.dart';
import '../../../domain/usecases/sofa_usecase/get_all_sofas_usecase.dart';
import '../../../domain/usecases/sofa_usecase/get_top_sofa_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/sofa_usecase/search_for_sofas_usecase.dart';

part 'sofa_event.dart';
part 'sofa_state.dart';

class SofaBloc extends Bloc<SofaEvent, SofaState> {
  final GetTopSofaUseCase getTopSofaUseCase;
  final GetAllSofasUseCase getAllSofasUseCase;
  final SearchForSofasUseCase searchForSofasUseCase;

  SofaBloc(this.getTopSofaUseCase, this.getAllSofasUseCase,
      this.searchForSofasUseCase)
      : super(const SofaState()) {
    on<GetTopSofaEvent>(_getTopSofa);
    on<GetAllSofasEvent>(_getAllSofas);
    on<SearchForSofasEvent>(_searchForSofas);
  }

  FutureOr<void> _getTopSofa(
      GetTopSofaEvent event, Emitter<SofaState> emit) async {
    final result = await getTopSofaUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            sofaState: RequestState.error, sofaMessage: l.message)),
        (r) => emit(state.copyWith(
              sofaList: r,
              sofaState: RequestState.loaded,
            )));
  }

  FutureOr<void> _getAllSofas(
      GetAllSofasEvent event, Emitter<SofaState> emit) async {
    final result = await getAllSofasUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            sofaState: RequestState.error, sofaMessage: l.message)),
        (r) => emit(state.copyWith(
              sofaList: r,
              sofaState: RequestState.loaded,
            )));
  }

  FutureOr<void> _searchForSofas(
      SearchForSofasEvent event, Emitter<SofaState> emit) async {
    final result = await searchForSofasUseCase(event.searchTitle);

    result.fold(
        (l) => emit(state.copyWith(
            sofaState: RequestState.error, sofaMessage: l.message)),
        (r) => emit(state.copyWith(
              sofaList: r,
              sofaState: RequestState.loaded,
            )));
  }
}
