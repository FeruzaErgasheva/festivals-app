import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:festivals_exam_4/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/blocs/auth/auth_bloc.dart';
import '../ui/screens/home_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.light,
      builder: (light, dark) => MaterialApp(
        theme: light,
        darkTheme: dark,
        home: BlocConsumer<AuthBloc, AuthState>(
          bloc: context.read<AuthBloc>()..add(CheckTokenExpiryEvent()),
          listener: (context, state) {
            if (state is LoadingAuthState) {
              showDialog(
                context: context,
                builder: (ctx) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                },
              );
            }

            if (state is ErrorAuthState || state is AuthenticatedAuthState) {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pop();
            }
          },
          builder: (context, state) {
            if (state is AuthenticatedAuthState) {
              return const HomeScreen();
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
