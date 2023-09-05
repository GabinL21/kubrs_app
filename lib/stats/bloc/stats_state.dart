part of 'stats_bloc.dart';

sealed class StatsState extends Equatable {
  const StatsState(this.solves);

  final List<Solve> solves;

  @override
  List<Object> get props => [solves];
}

final class StatsInitial extends StatsState {
  StatsInitial() : super(List.empty());
}

final class StatsLoading extends StatsState {
  StatsLoading() : super(List.empty());
}

final class StatsLoaded extends StatsState {
  const StatsLoaded(super.solves);
}
