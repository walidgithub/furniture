part of 'cupboard_bloc.dart';

class CupboardState extends Equatable {
  final List<Cupboard> cupboardList;
  final RequestState cupboardState;
  final String cupboardMessage;

  const CupboardState({
    this.cupboardList = const [],
    this.cupboardState = RequestState.loading,
    this.cupboardMessage = '',
  });

  CupboardState copyWith({
    List<Cupboard>? cupboardList,
    RequestState? cupboardState,
    String? cupboardMessage,
  }) {
    return CupboardState(
      cupboardList: cupboardList ?? this.cupboardList,
      cupboardState: cupboardState ?? this.cupboardState,
      cupboardMessage: cupboardMessage ?? this.cupboardMessage,
    );
  }

  @override
  List<Object?> get props => [cupboardList, cupboardState, cupboardMessage];
}
