import 'package:flutter/material.dart';
import 'package:gestion_tareas/providers/home_provider.dart';
import 'package:gestion_tareas/providers/task_provider.dart';
import 'package:gestion_tareas/router/my_go_router.dart';
import 'package:gestion_tareas/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'helpers/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<TaskProvider>(create: (_) => TaskProvider()),
      ],
      child: MaterialApp.router(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es'),
        ],
        locale: const Locale('es'),
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: AppTheme().theme(),
        routerConfig: myGoRouter,
      ),
    );
  }
}
