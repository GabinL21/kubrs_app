import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kubrs_app/history/view/history_page.dart';
import 'package:kubrs_app/stats/view/stats_page.dart';
import 'package:kubrs_app/timer/timer.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationTimer()) {
    on<NavigateToIndex>((event, emit) {
      switch (event.index) {
        case 0:
          emit(const NavigationHistory());
          break;
        case 1:
          emit(const NavigationTimer());
          break;
        case 2:
          emit(const NavigationStats());
          break;
      }
    });
  }
}
