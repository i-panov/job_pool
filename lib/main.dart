import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/ui/routing/app_router.dart';

void main() {
  runApp(ProviderScope(child: const JobPoolApp()));
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
