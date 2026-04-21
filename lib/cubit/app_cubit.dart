import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;
  Locale locale = const Locale('ar');

  void toggleTheme() {
    isDark = !isDark;
    emit(AppChangeThemeState());
  }

  void changeLocale() {
    if (locale.languageCode == 'ar') {
      locale = const Locale('en');
    } else {
      locale = const Locale('ar');
    }
    emit(AppChangeLocaleState());
  }
}