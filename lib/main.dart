import 'package:festivals_exam_4/data/repositories/auth_repository.dart';
import 'package:festivals_exam_4/data/repositories/festivals_repositories.dart';
import 'package:festivals_exam_4/firebase_options.dart';
import 'package:festivals_exam_4/logic/blocs/auth/auth_bloc.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_bloc.dart';
import 'package:festivals_exam_4/logic/blocs/theme/theme_bloc.dart';
import 'package:festivals_exam_4/services/auth_service.dart';
import 'package:festivals_exam_4/services/festivals_http_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firebaseAuthService = FirebaseAuthService();
  final FestivalsHttpServices festivalsHttpServices = FestivalsHttpServices();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) {
            return AuthRepository(
              firebaseAuthService: firebaseAuthService,
            );
          },
        ),
        RepositoryProvider(
          create: (context) {
            return FestivalsRepositories(
                festivalsHttpServices: festivalsHttpServices);
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) {
              return AuthBloc(
                authRepository: ctx.read<AuthRepository>(),
              );
            },
          ),
          BlocProvider(
            create: (ctx) {
              return FestivalsBloc(
                  festivalsRepositories: ctx.read<FestivalsRepositories>());
            },
          ),
          BlocProvider(
            create: (ctx) {
              return ThemeBloc();
            },
          ),
        ],
        child: const MainApp(),
      ),
    ),
  );
}
