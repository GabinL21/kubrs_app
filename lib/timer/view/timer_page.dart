import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/auth/auth.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';
import 'package:kubrs_app/timer/utils/scramble.dart';
import 'package:kubrs_app/timer/utils/ticker.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: const Ticker()),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final state = context.select((TimerBloc bloc) => bloc.state);
    if (state is! TimerInitial) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Expanded(child: _getBody()),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats),
            label: 'Stats',
          ),
        ],
        currentIndex: 1,
      ),
      drawer: _getDrawer(context, user),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              Scramble.generate(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Expanded(child: _getBody()),
          ],
        ),
      ),
    );
  }

  TimerGestureDetector _getBody() {
    return TimerGestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(child: TimerText()),
        ],
      ),
    );
  }

  Drawer _getDrawer(BuildContext context, User user) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 96, 32, 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hello ${user.displayName}!',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
              },
              child: Text(
                'Sign out',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
      return;
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

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final textString = _getTimerTextString(duration);
    final textStyle = _getTimerTextStyle(context);
    return Text(
      textString,
      style: textStyle,
    );
  }

  String _getTimerTextString(int duration) {
    final minutesStr = (duration / 1000 / 60).floor().toString();
    final secondsStr =
        (duration / 1000 % 60).floor().toString().padLeft(2, '0');
    final millisecondsStr =
        (duration % 1000 / 10).floor().toString().padLeft(2, '0');
    var textStr = '$secondsStr.$millisecondsStr';
    if (duration > 60 * 1000) textStr = '$minutesStr:$textStr';
    return textStr;
  }

  TextStyle _getTimerTextStyle(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayLarge!;
    if (context.select((TimerBloc bloc) => bloc.state) is TimerReseted) {
      return textStyle.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontSize: Theme.of(context).textTheme.displayLarge!.fontSize! * 1.10,
      );
    }
    return textStyle;
  }
}
