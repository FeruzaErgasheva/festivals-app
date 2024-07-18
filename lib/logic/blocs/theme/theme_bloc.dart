// import 'package:festivals_exam_4/logic/blocs/theme/theme_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'theme_events.dart';

// class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
//   ThemeBloc() : super(LightThemeState(ThemeData.dark())) {
//     on<ToggleThemeEvent>((event, emit) {
//       if (state is LightThemeState) {
//         emit(DarkThemeState(ThemeData.dark()));
//       } else {
//         emit(LightThemeState(ThemeData.light()));
//       }
//     });
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:festivals_exam_4/logic/blocs/theme/theme_events.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    on<ToggleThemeEvent>(_toggleTheme);
  }

  void _toggleTheme(event, emit) {
    if (state is LightThemeState) {
      emit(LightThemeState());
    }
  }

  // @override
  // Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
  //   if (event is ToggleThemeEvent) {
  //     if (state is LightThemeState) {
  //       yield DarkThemeState();
  //     } else {
  //       yield LightThemeState();
  //     }
  //   }
  // }
}
