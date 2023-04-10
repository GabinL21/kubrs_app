import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';

class TimerGestureDetector extends StatelessWidget {
  const TimerGestureDetector({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return GestureDetector(
          onLongPressStart: (_) => _handleLongPressStart(state, context),
          onLongPressEnd: (_) => _handleLongPressEnd(state, context),
          onPanDown: (_) => _handleOnPanDown(state, context),
          onTapUp: (_) => _handleOnTapUp(state, context),
          onPanEnd: (_) => _handleOnPanEnd(state, context),
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            child: child,
          ),
        );
      },
    );
  }

  void _handleLongPressStart(TimerState state, BuildContext context) {
    if (state is! TimerInitial) return;
    context.read<TimerBloc>().add(const TimerReset());
  }

  void _handleLongPressEnd(TimerState state, BuildContext context) {
    if (state is TimerComplete) {
      context.read<TimerBloc>().add(TimerDone(duration: state.duration));
    }
    if (state is! TimerReseted) return;
    context.read<TimerBloc>().add(const TimerStarted());
  }

  void _handleOnPanDown(TimerState state, BuildContext context) {
    if (state is TimerInitial) return;
    if (state is TimerComplete) {
      context.read<TimerBloc>().add(TimerDone(duration: state.duration));
    } else {
      context.read<TimerBloc>().add(TimerStopped(duration: state.duration));
    }
  }

  void _handleOnTapUp(TimerState state, BuildContext context) {
    if (state is TimerInitial) return;
    if (state is TimerComplete) {
      context.read<TimerBloc>().add(TimerDone(duration: state.duration));
    } else {
      context.read<TimerBloc>().add(TimerStopped(duration: state.duration));
    }
  }

  void _handleOnPanEnd(TimerState state, BuildContext context) {
    if (state is TimerComplete) {
      context.read<TimerBloc>().add(TimerDone(duration: state.duration));
    }
  }
}
