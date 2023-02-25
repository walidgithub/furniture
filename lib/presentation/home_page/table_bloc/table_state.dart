part of 'table_bloc.dart';

class TableState extends Equatable {
  final List<Dining> tableList;
  final RequestState tableState;
  final String tableMessage;

  const TableState({
    this.tableList = const [],
    this.tableState = RequestState.loading,
    this.tableMessage = '',
  });

  TableState copyWith({
    List<Dining>? tableList,
    RequestState? tableState,
    String? tableMessage,
  }) {
    return TableState(
      tableList: tableList ?? this.tableList,
      tableState: tableState ?? this.tableState,
      tableMessage: tableMessage ?? this.tableMessage,
    );
  }

  @override
  List<Object?> get props => [tableList, tableState, tableMessage];
}
