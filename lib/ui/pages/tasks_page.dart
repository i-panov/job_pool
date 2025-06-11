import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/ui/providers/app_providers.dart';
import 'package:job_pool/ui/routing/app_router.gr.dart';

@RoutePage(name: 'TasksTab')
class TasksPage extends ConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksValue = ref.watch(tasksProvider);
    return tasksValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Ошибка: $error')),
      data: (tasks) {
        if (tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.assignment, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'Нет заданий',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: tasks.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final task = tasks[index];
            return InkWell(
              onTap: () => context.router.push(VacancyRoute(vacancyId: task.vacancyId)),
              borderRadius: BorderRadius.circular(12),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              task.companyName,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.link, size: 16, color: Colors.blue[700]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              task.link,
                              style: TextStyle(
                                color: Colors.blue[700],
                                decoration: TextDecoration.underline,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Создано: ', style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500)),
                                  Text(_formatDate(task.createdAt), style: TextStyle(color: Colors.grey[700])),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text('Дедлайн: ', style: TextStyle(color: Colors.red[400], fontWeight: FontWeight.w500)),
                                  Text(_formatDate(task.deadline), style: TextStyle(color: Colors.red[400])),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (task.directions.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final dir in task.directions)
                              Chip(label: Text(dir)),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(date.year, date.month, date.day);
    if (d == today) {
      return 'Сегодня';
    } else if (d == today.add(const Duration(days: 1))) {
      return 'Завтра';
    } else {
      return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
    }
  }
}

final tasksProvider = StreamProvider.autoDispose((ref) {
  final db = ref.watch(dbProvider);
  return db.selectTasks().watch();
});
