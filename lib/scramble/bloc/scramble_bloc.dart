import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/scramble/utils/scramble.dart';

part 'scramble_event.dart';
part 'scramble_state.dart';

class ScrambleBloc extends Bloc<ScrambleEvent, ScrambleState> {
  ScrambleBloc() : super(const ScrambleLoading()) {
    on<GenerateScrambleEvent>((event, emit) async {
      emit(const ScrambleLoading());
      final scramble = await Scramble.generate();
      emit(ScrambleLoaded(scramble));
    });
    add(GenerateScrambleEvent()); // Initialize the first scramble
  }
}