part of 'chair_details_bloc.dart';

class ChairDetailsState extends Equatable {
  final List<ChairDetails> chairDetailsList;
  final RequestState chairDetailsState;
  final String chairDetailsMessage;

  const ChairDetailsState({
    this.chairDetailsList = const [],
    this.chairDetailsState = RequestState.loading,
    this.chairDetailsMessage = '',
  });

  ChairDetailsState copyWith({
    List<ChairDetails>? chairDetailsList,
    RequestState? chairDetailsState,
    String? chairDetailsMessage,
  }) {
    return ChairDetailsState(
      chairDetailsList: chairDetailsList ?? this.chairDetailsList,
      chairDetailsState: chairDetailsState ?? this.chairDetailsState,
      chairDetailsMessage: chairDetailsMessage ?? this.chairDetailsMessage,
    );
  }

  @override
  List<Object?> get props => [chairDetailsList, chairDetailsState, chairDetailsMessage];
}
