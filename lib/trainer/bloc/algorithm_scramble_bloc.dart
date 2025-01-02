import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/trainer/model/algorithm.dart';

part 'algorithm_scramble_event.dart';
part 'algorithm_scramble_state.dart';

class AlgorithmScrambleBloc
    extends Bloc<AlgorithmScrambleEvent, AlgorithmScrambleState> {
  AlgorithmScrambleBloc() : super(const AlgorithmScrambleInitial()) {
    on<GenerateAlgorithmScrambleEvent>(
      (event, emit) async {
        emit(const AlgorithmScrambleLoading());
        final scrambles = event.algorithm.scrambles;
        final random = Random();
        final scramble = scrambles[random.nextInt(scrambles.length)];
        emit(AlgorithmScrambleLoaded(scramble));
      },
    );
  }
}
