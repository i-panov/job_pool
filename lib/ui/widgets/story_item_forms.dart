import 'package:auto_route/auto_route.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_pool/core/validators.dart';
import 'package:job_pool/data/storage/db/db.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/data/storage/schemas/story_items.dart';
import 'package:job_pool/domain/models/story_item.dart';

Future<void> openStoryItemForm({
  required BuildContext context,
  required StoryItemType dtoType,
  required int vacancyId,
  required AppDatabase db,
}) async {
  final item = await showAdaptiveDialog<StoryItem?>(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dtoType.label),
            IconButton(
              onPressed: () => context.router.pop(),
              icon: Icon(Icons.close),
            ),
          ],
        ),
        content: switch (dtoType) {
          /*toryItemType.interview => InterviewStoryItemForm(),
          StoryItemType.waitingForFeedback => WaitingForFeedbackStoryItemForm(),
          StoryItemType.task => TaskStoryItemForm(),
          StoryItemType.failure => FailureStoryItemForm(),
          StoryItemType.offer => OfferStoryItemForm(),*/
          _ => _InterviewStoryItemForm(),
        },
      );
    },
  );

  if (item != null && item is InterviewStoryItem) {
    db.insertInterviewStoryItem(
      vacancyId: vacancyId,
      time: item.time,
      isOnline: item.isOnline,
      target: item.target,
      type: item.type,
    );
  }
}

class _InterviewStoryItemForm extends StatefulWidget {
  const _InterviewStoryItemForm();

  @override
  State<_InterviewStoryItemForm> createState() =>
      _InterviewStoryItemFormState();
}

class _InterviewStoryItemFormState extends State<_InterviewStoryItemForm> {
  var time = DateTime.now().add(const Duration(days: 1));
  var isOnline = true;

  var target = '';
  String? targetError;

  var type = InterviewType.hr;

  bool get hasError => targetError != null;

  @override
  void initState() {
    super.initState();
    _validateTarget();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        DateTimeFormField(
          initialValue: time,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          dateFormat: DateFormat('EEE, dd.MM HH:mm', 'ru_RU'),
          canClear: false,
          decoration: InputDecoration(labelText: 'Дата и время'),
          onChanged: (value) => setState(() {
            time = value ?? time;
          }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Офлайн'),
            Switch(
              value: isOnline,
              onChanged: (value) => setState(() {
                isOnline = value;
                _validateTarget();
              }),
            ),
            Text('Онлайн'),
          ],
        ),
        TextFormField(
          initialValue: target,
          decoration: InputDecoration(
            errorText: targetError,
            label: Text(isOnline ? 'Ссылка' : 'Место'),
          ),
          onChanged: (value) => setState(() {
            target = value;
            _validateTarget();
          }),
        ),
        DropdownButtonFormField<InterviewType>(
          value: type,
          items: [
            for (final type in InterviewType.values)
              DropdownMenuItem(value: type, child: Text(type.label)),
          ],
          onChanged: (value) => setState(() {
            type = value!;
          }),
        ),
        ElevatedButton(
          onPressed: hasError ? null : _submit,
          child: Text('Добавить'),
        ),
      ],
    );
  }

  void _submit() {
    if (!_validateTarget()) {
      setState(() {});
      return;
    }

    context.router.pop(
      InterviewStoryItem(
        id: 0,
        vacancyId: 0,
        createdAt: DateTime.now(),
        time: time,
        isOnline: isOnline,
        target: target,
        type: type,
      ),
    );
  }

  bool _validateTarget() {
    if (target.isEmpty) {
      targetError = 'Обязательное поле';
      return false;
    }

    if (isOnline && !AppValidator.url.isValid(target)) {
      targetError = 'Некорректный URL';
      return false;
    }

    targetError = null;
    return true;
  }
}
