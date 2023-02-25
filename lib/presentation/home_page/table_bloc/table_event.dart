part of 'table_bloc.dart';

abstract class TableEvent extends Equatable {
  const TableEvent();

  @override
  List<Object> get props => [];
}

class GetTopTableEvent extends TableEvent{}

class GetAllTablesEvent extends TableEvent{}

class SearchForTablesEvent extends TableEvent{
  final String searchTitle;

  SearchForTablesEvent(this.searchTitle);

  List<Object> get props => [searchTitle];
}