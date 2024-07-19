import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:festivals_exam_4/logic/blocs/auth/auth_bloc.dart';
import 'package:festivals_exam_4/ui/screens/home_screen.dart';
import 'package:festivals_exam_4/ui/screens/my_festivals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final currentThemeMode = AdaptiveTheme.of(context).mode;
      setState(() {
        isDark = currentThemeMode == AdaptiveThemeMode.dark;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(child: Icon(Icons.abc)),
          ListTile(
            title: const Text("Profile"),
            leading: IconButton(
              onPressed: () {
                // user page
              },
              icon: const Icon(Icons.person),
            ),
          ),
          ListTile(
            title: const Text("Home page"),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.home),
            ),
          ),
          ListTile(
            title: Text(isDark ? "Light Mode" : "Dark Mode"),
            leading: IconButton(
              onPressed: () {
                AdaptiveTheme.of(context).toggleThemeMode(useSystem: false);
                setState(() {
                  isDark = !isDark;
                });
              },
              icon: Icon(isDark ? Icons.wb_sunny : Icons.night_shelter),
            ),
          ),
          ListTile(
            title: const Text("Mening tadbirlarim"),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyFestivals(),
                ));
              },
              icon: const Icon(Icons.festival_sharp),
            ),
          ),
          ListTile(
            title: const Text("Language"),
            leading: IconButton(
              onPressed: () {
                //localization
              },
              icon: const Icon(Icons.language),
            ),
          ),
          ListTile(
            title: const Text("Logout"),
            leading: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
    );
  }
}
