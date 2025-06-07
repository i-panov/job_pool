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
  String? timeError;

  var isOnline = true;

  var target = '';
  String? targetError;

  var type = InterviewType.hr;

  bool get hasError => timeError != null || targetError != null;

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
          dateFormat: DateFormat('dd.MM.yyyy HH:mm'),
          canClear: false,
          decoration: InputDecoration(errorText: timeError),
          onChanged: (value) => setState(() {
            final error = _validateTime(value);

            if (error != null) {
              timeError = error;
            } else {
              timeError = null;
              time = value!;
            }
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
            final error = _validateTarget(value);

            if (error != null) {
              targetError = error;
            } else {
              targetError = null;
              target = value;
            }
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
    final newTimeError = _validateTime(time);

    if (newTimeError != null) {
      setState(() {
        timeError = newTimeError;
      });

      return;
    }

    final newTargetError = _validateTarget(target);

    if (newTargetError != null) {
      setState(() {
        targetError = newTargetError;
      });

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

  String? _validateTime(DateTime? value) {
    if (value == null) {
      return 'Обязательное поле';
    }

    if (value.isBefore(DateTime.now())) {
      return 'Дата не может быть в прошлом';
    }

    return null;
  }

  String? _validateTarget(String? value) {
    if (value == null || value.isEmpty) {
      return 'Обязательное поле';
    }

    if (isOnline && !AppValidator.url.isValid(value)) {
      return 'Некорректная ссылка';
    }

    return null;
  }
}
