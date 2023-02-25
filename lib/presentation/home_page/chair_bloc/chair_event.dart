part of 'chair_bloc.dart';

abstract class ChairEvent extends Equatable {
  const ChairEvent();

  @override
  List<Object> get props => [];
}

class GetTopChairEvent extends ChairEvent {}

class GetAllChairsEvent extends ChairEvent {}

class SearchForChairsEvent extends ChairEvent {
  final String searchTitle;

  SearchForChairsEvent(this.searchTitle);

  List<Object> get props => [searchTitle];
}
