import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:reports_app/features/start_screen/view/start_screen.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'cubit/app_cubit.dart';
import 'cubit/app_states.dart';
import 'features/report/view_model/cubit/report_cubit.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppCubit(),
        ),
        BlocProvider(create: (_) => ReportCubit()
        ),
      ], child: const AppView(),
    );
  }
}
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        final cubit = AppCubit.get(context);

        return  MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: cubit.isDark
              ? ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xff0D0D0D),
          )
              : ThemeData.light(),

          locale: cubit.locale,

          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          home: const StartScreen(),
        );
      },
    );
  }
}