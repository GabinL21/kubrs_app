part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent(this.index);
  final int index;

  @override
  List<Object> get props => [];
}

class NavigateToIndex extends NavigationEvent {
  const NavigateToIndex(super.index);
}
