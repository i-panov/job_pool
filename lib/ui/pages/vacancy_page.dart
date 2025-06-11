import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:job_pool/core/theme_utils.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/data/storage/schemas/story_items.dart';
import 'package:job_pool/domain/models/story_item.dart';
import 'package:job_pool/ui/providers/app_providers.dart';
import 'package:job_pool/ui/routing/app_router.gr.dart';
import 'package:job_pool/ui/widgets/story_item_forms.dart';
import 'package:job_pool/ui/widgets/grade_direction_chips.dart';
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.watchVacancyFullInfo(widget.vacancyId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final vacancy = snapshot.data!;

        final title = vacancy.directions.isEmpty
            ? vacancy.companyName
            : '${vacancy.companyName} (${vacancy.directions.first.name}${vacancy.directions.length > 2 ? ' +${vacancy.directions.length - 1}' : ''})';

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
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
          floatingActionButton: Theme(
            data: Theme.of(context).copyWith(cardColor: Colors.white),
            child: PopupMenuButton<StoryItemType>(
              icon: Icon(Icons.add_circle, color: Colors.green, size: 50),
              position: PopupMenuPosition.over,
              itemBuilder: (context) => [
                for (final type in StoryItemType.values)
                  PopupMenuItem(
                    value: type,
                    child: Row(
                      children: [
                        Icon(
                          switch (type) {
                            StoryItemType.interview => Icons.people,
                            StoryItemType.waitingForFeedback => Icons.schedule,
                            StoryItemType.task => Icons.assignment,
                            StoryItemType.failure => Icons.close,
                            StoryItemType.offer => Icons.check_circle,
                          },
                          color: switch (type) {
                            StoryItemType.failure => Colors.red,
                            StoryItemType.offer => Colors.green,
                            _ => null,
                          },
                        ),
                        SizedBox(width: 8),
                        Text(type.label),
                      ],
                    ),
                  ),
              ],
              onSelected: (type) => openStoryItemForm(
                context: context,
                dtoType: type,
                vacancyId: widget.vacancyId,
                db: db,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                Text(
                  'Компания',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                InkWell(
                  onTap: () => context.router.push(
                    CompanyRoute(companyId: vacancy.companyId),
                  ),
                  child: Text(
                    vacancy.companyName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'Ссылка на вакансию',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                InkWell(
                  onTap: () => launchUrlString(vacancy.link),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          vacancy.link,
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Icon(Icons.open_in_new, color: Colors.blue.shade700),
                    ],
                  ),
                ),
                if (vacancy.comment.isNotEmpty) ...[
                  Text(
                    'Комментарий',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    vacancy.comment,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
                Text(
                  'Направления',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                if (vacancy.directions.isEmpty)
                  Text('Список пуст')
                else
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final direction in vacancy.directions)
                        DirectionChip(name: direction.name),
                    ],
                  ),
                Text(
                  'Грейды',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                if (vacancy.grades.isEmpty)
                  Text('Список пуст')
                else
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final grade in vacancy.grades)
                        GradeChip(grade: grade),
                    ],
                  ),
                Text(
                  'Контакты',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    if (vacancy.contacts.isEmpty) Text('Список пуст'),

                    for (final contact in vacancy.contacts)
                      Chip(
                        avatar: Icon(switch (contact.type) {
                          ContactType.email => Icons.email,
                          ContactType.phone => Icons.phone,
                          ContactType.telegram => Icons.telegram,
                          ContactType.whatsapp => Ionicons.logo_whatsapp,
                        }),
                        label: InkWell(
                          onTap: () => launchUrlString(switch (contact.type) {
                            ContactType.email => 'mailto:${contact.value}',
                            ContactType.phone => 'tel:${contact.value}',
                            ContactType.telegram =>
                              'https://t.me/${contact.value}',
                            ContactType.whatsapp =>
                              'https://wa.me/${contact.value}',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'История',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.grey.shade700),
                        ),
                        SizedBox(height: 12),
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

  TextStyle get _labelStyle =>
      TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500);

  TextStyle get _valueStyle => TextStyle(color: Colors.grey.shade900);

  TextStyle get _linkStyle => TextStyle(
    color: Colors.blue.shade700,
    decoration: TextDecoration.underline,
  );

  TextStyle get _metaStyle =>
      TextStyle(color: Colors.grey.shade400, fontSize: 12);

  TextStyle get _titleStyle => TextStyle(
    color: StoryItemStyle.textColor(item.dtoType),
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  TextStyle get _dateStyle =>
      TextStyle(color: Colors.grey.shade900, fontWeight: FontWeight.w500);

  TextStyle get _dateSecondaryStyle =>
      TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: StoryItemStyle.borderColor(item.dtoType)),
      ),
      color: StoryItemStyle.backgroundColor(item.dtoType),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(context),
            if (_hasDate) ...[
              const SizedBox(height: 8),
              _buildDateInfo(context),
            ],
            const SizedBox(height: 12),
            _buildContent(context),
            const Divider(height: 24),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  bool get _hasDate =>
      item.data is InterviewStoryItemData ||
      item.data is WaitingForFeedbackStoryItemData ||
      item.data is TaskStoryItemData;

  Widget _buildTitle(BuildContext context) => Row(
    children: [
      Icon(
        StoryItemStyle.icon(item.dtoType),
        color: StoryItemStyle.textColor(item.dtoType),
      ),
      const SizedBox(width: 8),
      Text(item.dtoType.label, style: _titleStyle),
    ],
  );

  Widget _buildDateInfo(BuildContext context) {
    if (item.data is InterviewStoryItemData) {
      final data = item.data as InterviewStoryItemData;
      return _buildDateRow(
        icon: Icons.calendar_today,
        label: 'Назначено на:',
        date: data.time,
        context: context,
      );
    }

    if (item.data is WaitingForFeedbackStoryItemData) {
      final data = item.data as WaitingForFeedbackStoryItemData;
      return _buildDateRow(
        icon: Icons.schedule,
        label: 'Ждем ответ до:',
        date: data.time,
        context: context,
      );
    }

    if (item.data is TaskStoryItemData) {
      final data = item.data as TaskStoryItemData;
      return _buildDateRow(
        icon: Icons.timer,
        label: 'Срок выполнения до:',
        date: data.deadline,
        context: context,
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildDateRow({
    required IconData icon,
    required String label,
    required DateTime date,
    required BuildContext context,
  }) => Row(
    children: [
      Icon(icon, size: 16, color: Colors.grey.shade600),
      const SizedBox(width: 4),
      Text(label, style: _dateSecondaryStyle),
      const SizedBox(width: 4),
      Text(_formatDate(date), style: _dateStyle),
    ],
  );

  Widget _buildContent(BuildContext context) => switch (item.data) {
    InterviewStoryItemData data => _buildInterviewContent(data, context),
    WaitingForFeedbackStoryItemData data => _buildFeedbackContent(data),
    TaskStoryItemData data => _buildTaskContent(data, context),
    FailureStoryItemData data => _buildFailureContent(data),
    OfferStoryItemData data => _buildOfferContent(data, context),
  };

  Widget _buildInterviewContent(
    InterviewStoryItemData data,
    BuildContext context,
  ) {
    final typeRow = _buildInfoRow(
      context: context,
      label: 'Тип:',
      value: data.type.label,
    );

    final formatValue = data.isOnline ? 'Онлайн' : 'Офлайн';
    final formatColor = data.isOnline
        ? Colors.green.shade700
        : Colors.blue.shade700;
    final formatRow = _buildInfoRow(
      context: context,
      label: 'Формат:',
      value: formatValue,
      valueColor: formatColor,
    );

    final locationLabel = data.isOnline ? 'Ссылка:' : 'Место:';
    final locationRow = _buildInfoRow(
      context: context,
      label: locationLabel,
      value: data.target,
      isLink: data.isOnline,
      onTap: data.isOnline ? () => launchUrlString(data.target) : null,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [typeRow, formatRow, locationRow],
    );
  }

  Widget _buildFeedbackContent(WaitingForFeedbackStoryItemData data) {
    if (!data.comment.isNotEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Комментарий:', style: _labelStyle),
        const SizedBox(height: 4),
        Text(data.comment, style: _valueStyle),
      ],
    );
  }

  Widget _buildTaskContent(TaskStoryItemData data, BuildContext context) {
    return _buildInfoRow(
      context: context,
      label: 'Ссылка:',
      value: data.link,
      isLink: true,
      onTap: () => launchUrlString(data.link),
    );
  }

  Widget _buildFailureContent(FailureStoryItemData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Причина:', style: _labelStyle),
        const SizedBox(height: 4),
        Text(data.comment, style: _valueStyle),
      ],
    );
  }

  Widget _buildOfferContent(OfferStoryItemData data, BuildContext context) {
    final salaryStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.grey.shade900,
    );

    return _buildInfoRow(
      context: context,
      label: 'Зарплата:',
      value: '${data.salary} ₽',
      style: salaryStyle,
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
    required String label,
    required String value,
    bool isLink = false,
    VoidCallback? onTap,
    Color? valueColor,
    TextStyle? style,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Text(label, style: _labelStyle)),
        Expanded(
          flex: 5,
          child: isLink
              ? InkWell(
                  onTap: onTap,
                  child: Text(value, style: _linkStyle),
                )
              : Text(
                  value,
                  style:
                      style ??
                      TextStyle(color: valueColor ?? Colors.grey.shade900),
                ),
        ),
      ],
    ),
  );

  Widget _buildFooter(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Icon(Icons.access_time, size: 16, color: Colors.grey.shade400),
      const SizedBox(width: 4),
      Text('Добавлено: ${_formatDate(item.createdAt)}', style: _metaStyle),
    ],
  );

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck == today) {
      return DateFormat('HH:mm').format(date);
    }
    if (dateToCheck == today.subtract(const Duration(days: 1))) {
      return 'завтра в ${DateFormat('HH:mm').format(date)}';
    }
    return '${DateFormat('d MMMM', 'ru_RU').format(date)} в ${DateFormat('HH:mm').format(date)}';
  }
}
