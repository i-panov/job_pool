import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:job_pool/ui/providers/app_providers.dart';
import 'package:job_pool/ui/routing/app_router.gr.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage(name: 'HomeTab')
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(dbProvider);

    return StreamBuilder(
      stream: db.selectInterviews().watch(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final interviews = snapshot.data!;

        if (interviews.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'Нет запланированных собеседований',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        // Группируем собеседования по дате
        final groupedInterviews = interviews.groupListsBy((interview) {
          final date = interview.time;
          return DateTime(date.year, date.month, date.day);
        });

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: groupedInterviews.length,
          itemBuilder: (context, index) {
            final date = groupedInterviews.keys.elementAt(index);
            final dayInterviews = groupedInterviews[date]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    _formatDate(date),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                for (final interview in dayInterviews)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => context.pushRoute(
                                VacancyRoute(vacancyId: interview.vacancyId),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      interview.companyName,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.access_time, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    DateFormat.Hm().format(interview.time),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(width: 12),
                                  if (interview.isOnline)
                                    const Chip(
                                      label: Text('Онлайн'),
                                      backgroundColor: Colors.blue,
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  else
                                    const Chip(
                                      label: Text('Оффлайн'),
                                      backgroundColor: Colors.green,
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (interview.isOnline &&
                                interview.target.isNotEmpty) ...[
                              Row(
                                children: [
                                  const Icon(Icons.link, size: 16),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () =>
                                          launchUrlString(interview.target),
                                      child: Text(
                                        interview.target,
                                        style: TextStyle(
                                          color: Colors.blue.shade700,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.copy, size: 16),
                                    tooltip: 'Скопировать ссылку',
                                    onPressed: () async {
                                      await Clipboard.setData(
                                        ClipboardData(text: interview.target),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Ссылка скопирована в буфер обмена',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                            if (!interview.isOnline &&
                                interview.target.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 16),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      interview.target,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.map),
                                    onPressed: () => MapsLauncher.launchQuery(
                                      interview.target,
                                    ),
                                    tooltip: 'Открыть на карте',
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Сегодня';
    } else if (date == tomorrow) {
      return 'Завтра';
    } else {
      return DateFormat('d MMMM', 'ru').format(date);
    }
  }
}
