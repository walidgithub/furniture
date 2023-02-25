part of 'chair_details_bloc.dart';

abstract class ChairDetailsEvent extends Equatable {
  const ChairDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetChairDetailsEvent extends ChairDetailsEvent{
  final int idChair;

  GetChairDetailsEvent(this.idChair);

  List<Object> get props => [idChair];
}