import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl_standalone.dart';
import 'package:job_pool/ui/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();
  runApp(ProviderScope(child: const JobPoolApp()));
}

class JobPoolApp extends StatefulWidget {
  const JobPoolApp({super.key});

  @override
  State<JobPoolApp> createState() => JobPoolAppState();
}

class JobPoolAppState extends State<JobPoolApp> {
  final router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Job Pool',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      supportedLocales: [Locale('ru', 'RU')],
      locale: Locale('ru', 'RU'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: AppRouter().config(),
    );
  }
}
