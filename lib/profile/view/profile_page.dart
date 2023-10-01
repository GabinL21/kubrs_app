import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubrs_app/profile/bloc/profile_bloc.dart';
import 'package:kubrs_app/profile/view/profile_card.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:kubrs_app/user/bloc/user_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.userState,
    required this.solveRepository,
  });

  final UserState userState;
  final SolveRepository solveRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(solveRepository: solveRepository),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: ProfileView(userState: userState),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.userState});

  final UserState userState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 64, 48, 48),
      child: Column(
        children: [
          _getHeader(userState, theme),
          const SizedBox(height: 128),
          _getContent(context, theme),
        ],
      ),
    );
  }

  Widget _getHeader(UserState userState, ThemeData theme) {
    final userName =
        userState is UserLoaded ? userState.userName : 'Loading...';
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        userName,
        style: theme.textTheme.displayLarge,
      ),
    );
  }

  Widget _getContent(BuildContext context, ThemeData theme) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context)
      ..add(LoadProfile());
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getSolveCount(state, theme),
                _getTotalSolveTime(state, theme),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _getSolveCount(ProfileState profileState, ThemeData theme) {
    const label = 'Total Solves';
    if (profileState is! ProfileLoaded) {
      return const ProfileCard(label: label, value: '...');
    }
    final solveCount = NumberFormat.compact().format(profileState.solveCount);
    return ProfileCard(label: label, value: solveCount);
  }

  Widget _getTotalSolveTime(ProfileState profileState, ThemeData theme) {
    const label = 'Time Solving';
    if (profileState is! ProfileLoaded) {
      return const ProfileCard(label: label, value: '...');
    }
    final totalSolveTime = Duration(milliseconds: profileState.totalSolveTime);
    String displayedValue;
    if (totalSolveTime.inMinutes == 0) {
      displayedValue = '${totalSolveTime.inSeconds}s';
    } else if (totalSolveTime.inHours == 0) {
      displayedValue = '${totalSolveTime.inMinutes}m';
    } else {
      displayedValue = '${totalSolveTime.inHours}h';
    }
    return ProfileCard(label: label, value: displayedValue);
  }
}