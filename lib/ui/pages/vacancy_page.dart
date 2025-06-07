import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/data/storage/schemas/story_items.dart';
import 'package:job_pool/domain/models/story_item.dart';
import 'package:job_pool/ui/providers/app_providers.dart';
import 'package:job_pool/ui/routing/app_router.gr.dart';
import 'package:job_pool/ui/widgets/story_item_forms.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage()
class VacancyPage extends ConsumerStatefulWidget {
  final int vacancyId;

  const VacancyPage({super.key, required this.vacancyId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VacancyPageState();
}

class _VacancyPageState extends ConsumerState<VacancyPage> {
  late final db = ref.watch(dbProvider);

  late final vacancyQuery = db.getFullVacancyInfo(widget.vacancyId);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.watchFullVacancyInfo(widget.vacancyId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final vacancy = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text(vacancy.id.toString()),
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => context.router.push(
                  VacancyFormRoute(
                    vacancyId: vacancy.id,
                    companyId: vacancy.companyId,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: IconButton(
            icon: Icon(Icons.add_circle, color: Colors.green, size: 50),
            onPressed: () => openStoryItemForm(
              context: context,
              dtoType: StoryItemType.interview,
              vacancyId: widget.vacancyId,
              db: db,
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              spacing: 20,
              children: [
                Text(vacancy.companyName),
                Row(
                  children: [
                    Text(vacancy.link),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () {
                        launchUrlString(vacancy.link);
                      },
                    ),
                  ],
                ),
                if (vacancy.comment.isNotEmpty) Text(vacancy.comment),
                Text('Направления:'),
                for (final direction in vacancy.directions)
                  Text(direction.name),
                Text('Грейды:'),
                for (final grade in vacancy.grades) Text(grade.name),
                Text('Контакты:'),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    if (vacancy.contacts.isEmpty)
                      Text('Список пуст'),

                    for (final contact in vacancy.contacts)
                      Chip(
                        avatar: Icon(switch (contact.type) {
                          ContactType.email => Icons.email,
                          ContactType.phone => Icons.phone,
                          ContactType.telegram => Icons.telegram,
                        }),
                        label: InkWell(
                          onTap: () => launchUrlString(switch (contact.type) {
                            ContactType.email => 'mailto:${contact.value}',
                            ContactType.phone => 'tel:${contact.value}',
                            ContactType.telegram =>
                              'https://t.me/${contact.value}',
                          }),
                          child: Text(contact.value),
                        ),
                      ),
                  ],
                ),
                StreamBuilder(
                  stream: db.selectVacancyStory(widget.vacancyId).watch(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }

                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final story = snapshot.data!;

                    if (story.isEmpty) {
                      return Center(child: Text('История пуста'));
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('История'),
                        for (final item in story) _StoryItemCard(item: item),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StoryItemCard extends StatelessWidget {
  final StoryItem item;

  const _StoryItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: switch (item.data) {
          InterviewStoryItemData d => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(item.dtoType.label), Text(_formatDate(d.time))],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(d.type.label),
                  Text(d.isOnline ? 'Онлайн' : 'Офлайн'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(d.isOnline ? 'Ссылка: ' : 'Место: '),
                  Text(d.target),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Добавлено: '),
                  Text(_formatDate(item.createdAt)),
                ],
              ),
            ],
          ),
          _ => Text('Неизвестный тип'),
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('EEE, dd.MM в hh:mm', 'ru_RU').format(date);
  }
}
