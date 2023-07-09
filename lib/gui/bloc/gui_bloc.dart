import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gui_event.dart';
part 'gui_state.dart';

class GuiBloc extends Bloc<GuiEvent, GuiState> {
  GuiBloc() : super(GuiShowed()) {
    on<ShowGui>((event, emit) {
      emit(GuiShowed());
    });
    on<HideGui>((event, emit) {
      emit(GuiHidden());
    });
  }
}
