import 'package:collegenius/presentation/drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CollegeniusDrawer(),
      body: const Row(
        children: [
          Expanded(
            child: Column(
              children: [
                WeatherCard(),
                CourseInformationCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum WeatherType {
  sunny,
  cloudy,
  rainy,
  windy,
}

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 50,
              minWidth: 340,
              maxHeight: 50,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'NCU',
                        style: theme.textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Sunny',
                        style: theme.textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '32°',
                    style: theme.textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    WeatherIcons.day_sunny,
                    color: Colors.yellow,
                    size: 40,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseInformationCard extends StatelessWidget {
  const CourseInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(
            color: Color(0xff5e5e5e),
            width: 2,
          ),
        ),
        margin: const EdgeInsets.only(top: 20),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 60,
              minWidth: 340,
              maxHeight: 60,
              // Rememvber to remove the maxWidth:340
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.sync,
                          size: 30,
                        )),
                  ),
                ),
                Positioned(
                  left: 70,
                  top: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Now going',
                        style: theme.textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Introduction to Computer Science',
                        style: theme.textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
