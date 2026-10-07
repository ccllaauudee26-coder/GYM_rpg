import 'package:flutter/material.dart';

import 'app/app_initializer.dart';

import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/workouts_screen.dart';

import 'theme/app_theme.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const initializer = AppInitializer();

  await initializer.initialize();

  runApp(
    const ProvemApp(),
  );
}

class ProvemApp extends StatelessWidget {
  const ProvemApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PROVEM',
      theme: AppTheme.dark(),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: _buildCurrentScreen(),

    bottomNavigationBar: NavigationBar(
      selectedIndex: currentIndex,

      onDestinationSelected: (index) {
        if (index == currentIndex) {
          return;
        }

        setState(() {
          currentIndex = index;
        });
      },

      destinations: const [
        NavigationDestination(
          icon: Icon(
            Icons.home_outlined,
          ),
          selectedIcon: Icon(
            Icons.home_rounded,
          ),
          label: "Home",
        ),

        NavigationDestination(
          icon: Icon(
            Icons.fitness_center_outlined,
          ),
          selectedIcon: Icon(
            Icons.fitness_center_rounded,
          ),
          label: "Workouts",
        ),

        NavigationDestination(
          icon: Icon(
            Icons.person_outline_rounded,
          ),
          selectedIcon: Icon(
            Icons.person_rounded,
          ),
          label: "Profile",
        ),
      ],
    ),
  );
}

  Widget _buildCurrentScreen() {
    switch (currentIndex) {
      case 1:
        return const WorkoutsScreen();

      case 2:
        return ProfileScreen();

      default:
        return const HomeScreen();
    }
  }
}