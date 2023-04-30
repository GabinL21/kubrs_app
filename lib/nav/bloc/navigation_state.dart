part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState(this.index, this.page);
  final int index;
  final Widget page;

  @override
  List<Object> get props => [];
}

class NavigationHistory extends NavigationState {
  const NavigationHistory() : super(0, const Text('History'));
}

class NavigationTimer extends NavigationState {
  const NavigationTimer() : super(1, const TimerPage());
}
