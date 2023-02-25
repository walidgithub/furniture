part of 'sofa_bloc.dart';

class SofaState extends Equatable {
  final List<Sofa> sofaList;
  final RequestState sofaState;
  final String sofaMessage;

  const SofaState({
    this.sofaList = const [],
    this.sofaState = RequestState.loading,
    this.sofaMessage = '',
  });

  SofaState copyWith({
    List<Sofa>? sofaList,
    RequestState? sofaState,
    String? sofaMessage,
  }) {
    return SofaState(
      sofaList: sofaList ?? this.sofaList,
      sofaState: sofaState ?? this.sofaState,
      sofaMessage: sofaMessage ?? this.sofaMessage,
    );
  }

  @override
  List<Object?> get props => [sofaList, sofaState, sofaMessage];
}
