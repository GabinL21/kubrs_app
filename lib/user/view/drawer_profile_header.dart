import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/profile/view/profile_page.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:kubrs_app/user/bloc/user_bloc.dart';

class DrawerProfileHeader extends StatelessWidget {
  const DrawerProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => _navigateToProfilePage(context, state),
          child: _getHeaderContent(state, theme),
        );
      },
    );
  }

  Widget _getHeaderContent(UserState userState, ThemeData theme) {
    final circleAvatar = CircleAvatar(
      radius: 24,
      backgroundColor: theme.colorScheme.tertiary,
      child: const Icon(Icons.person),
    );
    final displayedUserName = Text(
      userState is UserLoaded ? userState.userName : 'Loading...',
      style: theme.textTheme.displayMedium,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        circleAvatar,
        const SizedBox(height: 24),
        displayedUserName,
        const SizedBox(height: 24),
        Divider(color: theme.colorScheme.secondary),
      ],
    );
  }

  void _navigateToProfilePage(BuildContext context, UserState state) {
    final solveRepository = RepositoryProvider.of<SolveRepository>(context);
    Navigator.of(context).push(
      MaterialPageRoute<Widget>(
        builder: (context) => ProfilePage(
          userState: state,
          solveRepository: solveRepository,
        ),
      ),
    );
  }
}
