part of 'gui_bloc.dart';

abstract class GuiState extends Equatable {
  const GuiState();

  @override
  List<Object> get props => [];
}

class GuiShowed extends GuiState {}

class GuiHidden extends GuiState {}
