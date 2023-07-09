part of 'gui_bloc.dart';

abstract class GuiEvent extends Equatable {
  const GuiEvent();

  @override
  List<Object> get props => [];
}

class ShowGui extends GuiEvent {}

class HideGui extends GuiEvent {}
