import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';
import 'package:flutter/material.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const _key = 'theme_mode';

  ThemeBloc() : super(ThemeState(ThemeMode.system)) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<ChangeThemeEvent>(_onChangeTheme);
  }

  Future<void> _onLoadTheme(
      LoadThemeEvent event,
      Emitter<ThemeState> emit,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);

    if (saved == 'light') {
      emit(ThemeState(ThemeMode.light));
    } else if (saved == 'dark') {
      emit(ThemeState(ThemeMode.dark));
    } else {
      emit(ThemeState(ThemeMode.system));
    }
  }

  Future<void> _onChangeTheme(
      ChangeThemeEvent event,
      Emitter<ThemeState> emit,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    if (event.themeMode == ThemeMode.light) {
      await prefs.setString(_key, 'light');
    } else if (event.themeMode == ThemeMode.dark) {
      await prefs.setString(_key, 'dark');
    } else {
      await prefs.setString(_key, 'system');
    }

    emit(ThemeState(event.themeMode));
  }
}
