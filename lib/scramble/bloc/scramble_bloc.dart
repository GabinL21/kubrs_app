import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/scramble/utils/scramble_generator.dart';

part 'scramble_event.dart';
part 'scramble_state.dart';

class ScrambleBloc extends Bloc<ScrambleEvent, ScrambleState> {
  ScrambleBloc() : super(const ScrambleInitial()) {
    on<GenerateScrambleEvent>(
      (event, emit) async {
        emit(const ScrambleLoading());
        final scramble = await generateScramble();
        emit(ScrambleLoaded(scramble));
      },
    );
    add(GenerateScrambleEvent()); // Initialize the first scramble
  }

  Future<String> generateScramble() async {
    return ScrambleGenerator.generate();
  }
}
