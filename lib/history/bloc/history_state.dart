part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState(this.solves);
  final List<Solve> solves;

  @override
  List<Object> get props => [solves];
}

class HistoryInitial extends HistoryState {
  HistoryInitial() : super(List.empty());
}

class HistoryLoading extends HistoryState {
  HistoryLoading() : super(List.empty());
}

class HistoryLoaded extends HistoryState {
  const HistoryLoaded(super.solves);
}
