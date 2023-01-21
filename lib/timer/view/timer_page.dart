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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Center(child: TimerText()),
          ),
          StartButton(),
          StopButton(),
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final secondsStr = (duration / 1000).floor().toString().padLeft(2, '0');
    final millisecondsStr =
        (duration % 1000 / 10).floor().toString().padLeft(2, '0');
    return Text(
      '$secondsStr.$millisecondsStr',
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.play_arrow),
      onPressed: () => context.read<TimerBloc>().add(const TimerStarted()),
    );
  }
}

class StopButton extends StatelessWidget {
  const StopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return FloatingActionButton(
          child: const Icon(Icons.stop),
          onPressed: () => context
              .read<TimerBloc>()
              .add(TimerStopped(duration: state.duration)),
        );
      },
    );
  }
}
