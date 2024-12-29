import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/scramble/utils/scramble_generator.dart';
import 'package:kubrs_app/trainer/model/cube_pattern.dart';

part 'pattern_scramble_event.dart';
part 'pattern_scramble_state.dart';

class PatternScrambleBloc
    extends Bloc<PatternScrambleEvent, PatternScrambleState> {
  PatternScrambleBloc() : super(const PatternScrambleInitial()) {
    on<GeneratePatternScrambleEvent>(
      (event, emit) async {
        emit(const PatternScrambleLoading());
        final cubePattern = event.pattern.toCube();
        final scramble = await ScrambleGenerator.generateToCube(cubePattern);
        emit(PatternScrambleLoaded(scramble));
      },
    );
  }
}
