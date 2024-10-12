import 'package:collegenius/core/utils/collegenius_snackbar.dart';
import 'package:collegenius/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollegeniusDrawer extends StatelessWidget {
  const CollegeniusDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SizedBox(
            width: 240,
            child: Drawer(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  CollegeniusDrawerHeader(authState: state),
                  const Divider(),
                  ListTile(
                    title: const Text('Course Schedule'),
                    leading: const Icon(Icons.calendar_today),
                    onTap: () {
                      if (state.runtimeType != AuthenticatedMultiple) {
                        collegeniusSnackBar(context,'Log in to view course schedule');
                        return;
                      } else {
                        Navigator.of(context).pushNamed('/courseschedule');
                      }
                    },
                  ),
                  ListTile(
                    title: const Text('Course Schedule'),
                    leading: const Icon(Icons.calendar_today),
                    onTap: () {
                      print('aaa');
                    },
                  ),
                  ListTile(
                    title: const Text('Course Schedule'),
                    leading: const Icon(Icons.calendar_today),
                    onTap: () {
                      print('aaa');
                    },
                  ),
                  ListTile(
                    title: const Text('Course Schedule'),
                    leading: const Icon(Icons.calendar_today),
                    onTap: () {
                      print('aaa');
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class CollegeniusDrawerHeader extends StatelessWidget {
  final AuthState authState;
  const CollegeniusDrawerHeader({super.key, required this.authState});

  @override
  Widget build(BuildContext context) {
    switch (authState.runtimeType) {
      case const (AuthenticatedMultiple):
        return const CollegeniusDrawerHeaderAuthenticated();
      default:
        return const CollegeniusDrawerHeaderUnauthenticated();
    }
  }
}

class CollegeniusDrawerHeaderUnauthenticated extends StatelessWidget {
  const CollegeniusDrawerHeaderUnauthenticated({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 200,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          onTap: () {
            Navigator.of(context).pushNamed('/login');
          },
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 91, 91, 91),
                        borderRadius: BorderRadius.circular(22.5),
                      ),
                      child: const Icon(
                        Icons.account_circle_outlined,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Log in',
                      style: theme.textTheme.labelMedium,
                    ),
                    const SizedBox(width: 50),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CollegeniusDrawerHeaderAuthenticated extends StatelessWidget {
  const CollegeniusDrawerHeaderAuthenticated({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 200,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          onTap: () {
            Navigator.of(context).pushNamed('/login');
          },
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: InkWell(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 91, 91, 91),
                          borderRadius: BorderRadius.circular(22.5),
                        ),
                        child: const Icon(
                          Icons.account_circle_outlined,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Welcome',
                        style: theme.textTheme.labelMedium,
                      ),
                      const SizedBox(width: 50),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
