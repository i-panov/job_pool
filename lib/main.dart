import 'package:flutter/material.dart';
import 'package:job_pool/data/storage/db/db.dart';
import 'package:job_pool/ui/routing/app_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => AppDatabase()),
    ],
    child: const JobPoolApp(),
  ));
}

class JobPoolApp extends StatelessWidget {
  const JobPoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Job Pool',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppRouter().config(),
    );
  }
}
