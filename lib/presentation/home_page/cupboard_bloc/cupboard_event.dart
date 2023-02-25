part of 'cupboard_bloc.dart';

abstract class CupboardEvent extends Equatable {
  const CupboardEvent();

  @override
  List<Object> get props => [];
}

class GetTopCupboardEvent extends CupboardEvent{}

class GetAllCupboardsEvent extends CupboardEvent{}

class SearchForCupboardsEvent extends CupboardEvent{
  final String searchTitle;

  SearchForCupboardsEvent(this.searchTitle);

  List<Object> get props => [searchTitle];
}