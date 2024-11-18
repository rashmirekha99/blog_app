import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.dark) {
    on<ThemeChanged>((event, emit) {
      if (event.isDark) {
        emit(ThemeMode.dark);
      } else {
        emit(ThemeMode.light);
      }
    });
  }
}
