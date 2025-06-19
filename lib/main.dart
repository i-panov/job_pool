import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl_standalone.dart';
import 'package:job_pool/core/parse.dart';
import 'package:job_pool/ui/providers/parsing_provider.dart';
import 'package:job_pool/ui/routing/app_router.dart';
import 'package:job_pool/ui/routing/app_router.gr.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();
  runApp(ProviderScope(child: const JobPoolApp()));
}

class JobPoolApp extends ConsumerStatefulWidget {
  const JobPoolApp({super.key});

  @override
  ConsumerState createState() => JobPoolAppState();
}

class JobPoolAppState extends ConsumerState<JobPoolApp> {
  final router = AppRouter();

  late final StreamSubscription _shareSub;

  BuildContext get ctx => router.navigatorKey.currentContext!;

  @override
  void initState() {
    super.initState();

    ref.listen(parsingProvider, (_, next) {
      if (next is ParsingSuccess) {
        ctx.router.push(VacancyRoute(vacancyId: next.vacancyId));
      } else if (next is ParsingFailure) {
        final snack = SnackBar(content: Text(next.error));
        ScaffoldMessenger.of(ctx).showSnackBar(snack);
      }
    });

    _shareSub = ReceiveSharingIntent.instance.getMediaStream().listen(
      _processShared,
    );

    ReceiveSharingIntent.instance.getInitialMedia().then(_processShared);
  }

  @override
  void dispose() {
    _shareSub.cancel();
    super.dispose();
  }

  void _processShared(List<SharedMediaFile> sharedItems) {
    if (sharedItems.isNotEmpty) {
      final shared = sharedItems.first;

      if (shared.type == SharedMediaType.text) {
        final text = shared.path;
        final uri = tryParseHeadHunterVacancyUrl(text);

        if (uri != null) {
          ref.read(parsingProvider.notifier).parse(uri);
        }
      }
    }
  }

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
      routerConfig: router.config(),
    );
  }
}
