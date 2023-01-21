import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'solve_timer_event.dart';
part 'solve_timer_state.dart';

class SolveTimerBloc extends Bloc<SolveTimerEvent, SolveTimerState> {
  SolveTimerBloc() : super(SolveTimerInitial()) {
    on<SolveTimerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
