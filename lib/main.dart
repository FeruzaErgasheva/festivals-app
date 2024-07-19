import 'package:festivals_exam_4/data/repositories/auth_repository.dart';
import 'package:festivals_exam_4/data/repositories/festivals/festivals_repositories.dart';
import 'package:festivals_exam_4/data/repositories/festivals/near_festivals_repository.dart';
import 'package:festivals_exam_4/data/repositories/festivals/personal_festivals_repositories.dart';
import 'package:festivals_exam_4/firebase_options.dart';
import 'package:festivals_exam_4/logic/blocs/auth/auth_bloc.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_bloc.dart';
import 'package:festivals_exam_4/logic/blocs/near_fetsivals/near_festivals_bloc.dart';
import 'package:festivals_exam_4/logic/blocs/personal_festivals/personal_festivals_bloc.dart';
import 'package:festivals_exam_4/logic/blocs/theme/theme_bloc.dart';
import 'package:festivals_exam_4/services/auth_service.dart';
import 'package:festivals_exam_4/services/festivals/festivals_http_services.dart';
import 'package:festivals_exam_4/services/festivals/near_festivals_http.dart';
import 'package:festivals_exam_4/services/festivals/personal_festivals_http_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firebaseAuthService = FirebaseAuthService();
  final FestivalsHttpServices festivalsHttpServices = FestivalsHttpServices();
  final PersonalFestivalsHttpServices personalFestivalsHttpServices =
      PersonalFestivalsHttpServices();

      final NearFestivalsHttpServices nearFestivalsHttpServices=NearFestivalsHttpServices();

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
        RepositoryProvider(
          create: (context) {
            return PersonalFestivalsRepositories(
                personalFestivalsHttpServices: personalFestivalsHttpServices);
          },
        ),
        RepositoryProvider(
          create: (context) {
            return NearFestivalsRepository(
                nearFestivalsHttpServices: nearFestivalsHttpServices);
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
              return PersonalFestivalsBloc(
                  personalFestivalsRepositories:
                      ctx.read<PersonalFestivalsRepositories>());
            },
          ),
          BlocProvider(
            create: (ctx) {
              return NearFestivalsBloc(
                  nearFestivalsRepositories:
                      ctx.read<NearFestivalsRepository>());
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
