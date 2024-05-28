
import 'package:app_educacion_financiera/config/Provider/estudiante_provider.dart';
import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:app_educacion_financiera/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';



Future <void> main() async {
  await dotenv.load(fileName: ".env");
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => EstudianteModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Educación Financiera',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
