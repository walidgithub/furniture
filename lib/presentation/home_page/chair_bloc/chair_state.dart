part of 'chair_bloc.dart';

class ChairState extends Equatable {
  final List<Chair> chairList;
  final RequestState chairState;
  final String chairMessage;

  const ChairState({
    this.chairList = const [],
    this.chairState = RequestState.loading,
    this.chairMessage = '',
  });

  ChairState copyWith({
    List<Chair>? chairList,
    RequestState? chairState,
    String? chairMessage,
  }) {
    return ChairState(
      chairList: chairList ?? this.chairList,
      chairState: chairState ?? this.chairState,
      chairMessage: chairMessage ?? this.chairMessage,
    );
  }

  @override
  List<Object?> get props => [chairList, chairState, chairMessage];
}
