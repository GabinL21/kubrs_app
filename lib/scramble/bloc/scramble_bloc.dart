import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/scramble/utils/scramble_generator.dart';
import 'package:stream_transform/stream_transform.dart';

part 'scramble_event.dart';
part 'scramble_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ScrambleBloc extends Bloc<ScrambleEvent, ScrambleState> {
  ScrambleBloc() : super(const ScrambleInitial()) {
    on<GenerateScrambleEvent>(
      (event, emit) async {
        if (state is ScrambleLoading) return;
        emit(const ScrambleLoading());
        final scramble = await ScrambleGenerator.generate();
        emit(ScrambleLoaded(scramble));
      },
      transformer: throttleDroppable(throttleDuration),
    );
    add(GenerateScrambleEvent()); // Initialize the first scramble
  }

  static const throttleDuration = Duration(milliseconds: 1500);
}
