import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/scramble/bloc/scramble_bloc.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';
import 'package:kubrs_app/timer/view/timer_gesture_detector.dart';
import 'package:kubrs_app/timer/view/timer_text.dart';
import 'package:kubrs_app/user/bloc/user_bloc.dart';
import 'package:kubrs_app/user/user.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserInitial) userBloc.add(UserRequested());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TimerBloc(),
        ),
        BlocProvider(
          create: (_) => ScrambleBloc(),
        ),
      ],
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
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
      drawer: const UserDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              context.select((ScrambleBloc bloc) => bloc.state.scramble),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Expanded(child: _getBody()),
          ],
        ),
      ),
    );
  }

  Widget _getBody() {
    return TimerGestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(child: TimerText()),
        ],
      ),
    );
  }
}
