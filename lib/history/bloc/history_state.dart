part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState(this.solves, this.lastDocument);
  final List<Solve> solves;
  final DocumentSnapshot? lastDocument;

  @override
  List<Object> get props => [solves];
}

class HistoryInitial extends HistoryState {
  HistoryInitial() : super(List.empty(), null);
}

class HistoryLoading extends HistoryState {
  HistoryLoading() : super(List.empty(), null);
}

class HistoryLoadingNext extends HistoryState {
  const HistoryLoadingNext(List<Solve> solves) : super(solves, null);
}

class HistoryLoaded extends HistoryState {
  const HistoryLoaded(super.solves, super.lastDocument);
}

class HistoryFullyLoaded extends HistoryState {
  const HistoryFullyLoaded(super.solves, super.lastDocument);
}
