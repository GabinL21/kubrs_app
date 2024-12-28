part of 'algorithms_bloc.dart';

abstract class AlgorithmsEvent extends Equatable {
  const AlgorithmsEvent();

  @override
  List<Object> get props => [];
}

class LoadAlgorithms extends AlgorithmsEvent {}
