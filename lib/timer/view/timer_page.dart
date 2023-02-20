import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';
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
      drawer: const Drawer(),
      body: TimerGestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 100),
              child: Center(child: TimerText()),
            ),
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
          onLongPressStart: (_) =>
              context.read<TimerBloc>().add(const TimerReset()),
          onLongPressEnd: (_) =>
              context.read<TimerBloc>().add(const TimerStarted()),
          onTapDown: (_) => state.duration > 0
              ? context
                  .read<TimerBloc>()
                  .add(TimerStopped(duration: state.duration))
              : null,
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            child: child,
          ),
        );
      },
    );
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
    if (context.select((TimerBloc bloc) => bloc.state.reseted)) {
      return textStyle.copyWith(color: Theme.of(context).colorScheme.tertiary);
    }
    return textStyle;
  }
}
