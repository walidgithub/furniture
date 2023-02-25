part of 'sofa_bloc.dart';

abstract class SofaEvent extends Equatable {
  const SofaEvent();

  @override
  List<Object> get props => [];
}

class GetTopSofaEvent extends SofaEvent{}

class GetAllSofasEvent extends SofaEvent{}

class SearchForSofasEvent extends SofaEvent{
  final String searchTitle;

  SearchForSofasEvent(this.searchTitle);

  List<Object> get props => [searchTitle];
}