import 'dart:async';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../../domain/model/models.dart';
import '../../../domain/usecases/table_usecase/get_all_tables_usecase.dart';
import '../../../domain/usecases/table_usecase/get_top_table_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/table_usecase/search_for_tables_usecase.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  final GetTopTableUseCase getTopTableUseCase;
  final GetAllTablesUseCase getAllTablesUseCase;
  final SearchForTablesUseCase searchForTablesUseCase;

  TableBloc(this.getTopTableUseCase, this.getAllTablesUseCase,
      this.searchForTablesUseCase)
      : super(const TableState()) {
    on<GetTopTableEvent>(_getTopTable);
    on<GetAllTablesEvent>(_getAllTables);
    on<SearchForTablesEvent>(_searchForTables);
  }

  FutureOr<void> _getTopTable(
      GetTopTableEvent event, Emitter<TableState> emit) async {
    final result = await getTopTableUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            tableState: RequestState.error, tableMessage: l.message)),
        (r) => emit(state.copyWith(
              tableList: r,
              tableState: RequestState.loaded,
            )));
  }

  FutureOr<void> _getAllTables(
      GetAllTablesEvent event, Emitter<TableState> emit) async {
    final result = await getAllTablesUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            tableState: RequestState.error, tableMessage: l.message)),
        (r) => emit(state.copyWith(
              tableList: r,
              tableState: RequestState.loaded,
            )));
  }

  FutureOr<void> _searchForTables(
      SearchForTablesEvent event, Emitter<TableState> emit) async {
    final result = await searchForTablesUseCase(event.searchTitle);

    result.fold(
        (l) => emit(state.copyWith(
            tableState: RequestState.error, tableMessage: l.message)),
        (r) => emit(state.copyWith(
              tableList: r,
              tableState: RequestState.loaded,
            )));
  }
}
