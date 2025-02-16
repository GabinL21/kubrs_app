part of 'algorithms_bloc.dart';

abstract class AlgorithmsState extends Equatable {
  const AlgorithmsState(this.algorithmGroups);

  final List<AlgorithmGroup> algorithmGroups;

  @override
  List<Object> get props => [algorithmGroups];
}

class AlgorithmsInitial extends AlgorithmsState {
  const AlgorithmsInitial() : super(const []);
}

class AlgorithmsLoading extends AlgorithmsState {
  const AlgorithmsLoading() : super(const []);
}

class AlgorithmsLoaded extends AlgorithmsState {
  const AlgorithmsLoaded(super.algorithmGroups);
}
