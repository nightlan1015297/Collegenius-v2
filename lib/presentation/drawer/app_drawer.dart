import 'package:flutter/material.dart';

class CollegeniusDrawer extends StatelessWidget {
  const CollegeniusDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
        width: 250,
        child: Drawer(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              const CollegeniusDrawerHeader(),
              const Divider(),
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
  }
}

class CollegeniusDrawerHeader extends StatelessWidget {
  const CollegeniusDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 240,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
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
                  const SizedBox(width: 10),
                  Text(
                    'Log in to view',
                    style: theme.textTheme.labelMedium,
                  ),
                  const SizedBox(width: 30),
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
    );
  }
}
