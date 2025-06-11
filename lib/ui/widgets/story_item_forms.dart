import 'package:auto_route/auto_route.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final data = await showAdaptiveDialog<StoryItemData?>(
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
          StoryItemType.interview => _InterviewStoryItemForm(),
          StoryItemType.waitingForFeedback =>
            _WaitingForFeedbackStoryItemForm(),
          StoryItemType.task => _TaskStoryItemForm(),
          StoryItemType.failure => _FailureStoryItemForm(),
          StoryItemType.offer => _OfferStoryItemForm(),
        },
      );
    },
  );

  if (data == null) return;

  switch (data) {
    case InterviewStoryItemData():
      db.insertInterviewStoryItem(vacancyId: vacancyId, data: data);
    case WaitingForFeedbackStoryItemData():
      db.insertWaitingForFeedbackStoryItem(vacancyId: vacancyId, data: data);
    case TaskStoryItemData():
      db.insertTaskStoryItem(vacancyId: vacancyId, data: data);
    case FailureStoryItemData():
      db.insertFailureStoryItem(vacancyId: vacancyId, data: data);
    case OfferStoryItemData():
      db.insertOfferStoryItem(vacancyId: vacancyId, data: data);
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

  void _submit() {
    if (!_validateTarget()) {
      if (mounted) {
        setState(() {});
      }
      return;
    }

    context.router.pop(
      InterviewStoryItemData(
        time: time,
        isOnline: isOnline,
        target: target,
        type: type,
      ),
    );
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
          onChanged: (value) {
            if (mounted) {
              setState(() {
                time = value ?? time;
              });
            }
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Офлайн'),
            Switch(
              value: isOnline,
              onChanged: (value) {
                if (mounted) {
                  setState(() {
                    isOnline = value;
                    _validateTarget();
                  });
                }
              },
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
          onChanged: (value) {
            if (mounted) {
              setState(() {
                target = value;
                _validateTarget();
              });
            }
          },
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

  bool _validateTarget() {
    // if (target.isEmpty) {
    //   targetError = 'Обязательное поле';
    //   return false;
    // }

    if (isOnline && target.isNotEmpty && !AppValidator.url.isValid(target)) {
      targetError = 'Некорректный URL';
      return false;
    }

    targetError = null;
    return true;
  }
}

class _WaitingForFeedbackStoryItemForm extends StatefulWidget {
  const _WaitingForFeedbackStoryItemForm();

  @override
  State<_WaitingForFeedbackStoryItemForm> createState() =>
      _WaitingForFeedbackStoryItemFormState();
}

class _WaitingForFeedbackStoryItemFormState
    extends State<_WaitingForFeedbackStoryItemForm> {
  var time = DateTime.now().add(const Duration(days: 1));
  var comment = '';

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
          decoration: InputDecoration(labelText: 'Дата и время'),
          onChanged: (value) {
            if (mounted) {
              setState(() {
                time = value ?? time;
              });
            }
          },
        ),
        TextFormField(
          initialValue: comment,
          maxLines: 3,
          decoration: InputDecoration(labelText: 'Комментарий'),
          onChanged: (value) {
            if (mounted) {
              setState(() {
                comment = value;
              });
            }
          },
        ),
        ElevatedButton(
          onPressed: () => context.router.pop(
            WaitingForFeedbackStoryItemData(time: time, comment: comment),
          ),
          child: Text('Добавить'),
        ),
      ],
    );
  }
}

class _TaskStoryItemForm extends StatefulWidget {
  const _TaskStoryItemForm();

  @override
  State<_TaskStoryItemForm> createState() => _TaskStoryItemFormState();
}

class _TaskStoryItemFormState extends State<_TaskStoryItemForm> {
  var deadline = DateTime.now().add(const Duration(days: 7));
  var link = '';
  String? linkError;

  bool get hasError => linkError != null;

  @override
  void initState() {
    super.initState();
    _validateLink();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        DateTimeFormField(
          initialValue: deadline,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          dateFormat: DateFormat('EEE, dd.MM HH:mm', 'ru_RU'),
          decoration: InputDecoration(labelText: 'Дедлайн'),
          onChanged: (value) {
            if (mounted) {
              setState(() {
                deadline = value ?? deadline;
              });
            }
          },
        ),
        TextFormField(
          initialValue: link,
          decoration: InputDecoration(
            labelText: 'Ссылка на задание',
            errorText: linkError,
          ),
          onChanged: (value) {
            if (mounted) {
              setState(() {
                link = value;
                _validateLink();
              });
            }
          },
        ),
        ElevatedButton(
          onPressed: hasError ? null : _submit,
          child: Text('Добавить'),
        ),
      ],
    );
  }

  void _submit() {
    if (!_validateLink()) {
      if (mounted) setState(() {});
      return;
    }

    context.router.pop(TaskStoryItemData(deadline: deadline, link: link));
  }

  bool _validateLink() {
    if (link.isEmpty) {
      linkError = 'Обязательное поле';
      return false;
    }

    if (!AppValidator.url.isValid(link)) {
      linkError = 'Некорректный URL';
      return false;
    }

    linkError = null;
    return true;
  }
}

class _FailureStoryItemForm extends StatefulWidget {
  const _FailureStoryItemForm();

  @override
  State<_FailureStoryItemForm> createState() => _FailureStoryItemFormState();
}

class _FailureStoryItemFormState extends State<_FailureStoryItemForm> {
  var comment = '';
  String? commentError;

  bool get hasError => commentError != null;

  @override
  void initState() {
    super.initState();
    _validateComment();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          initialValue: comment,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Комментарий',
            errorText: commentError,
          ),
          onChanged: (value) => setState(() {
            comment = value;
            _validateComment();
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
    if (!_validateComment()) {
      if (mounted) {
        setState(() {});
      }
      return;
    }

    context.router.pop(FailureStoryItemData(comment: comment));
  }

  bool _validateComment() {
    if (comment.isEmpty) {
      commentError = 'Обязательное поле';
      return false;
    }

    commentError = null;
    return true;
  }
}

class _OfferStoryItemForm extends StatefulWidget {
  const _OfferStoryItemForm();

  @override
  State<_OfferStoryItemForm> createState() => _OfferStoryItemFormState();
}

class _OfferStoryItemFormState extends State<_OfferStoryItemForm> {
  var salary = 0;
  String? salaryError;

  bool get hasError => salaryError != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          initialValue: salary > 0 ? salary.toString() : '',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: 'Зарплата',
            errorText: salaryError,
          ),
          onChanged: (value) {
            if (mounted) {
              setState(() {
                salary = int.tryParse(value) ?? 0;
                _validateSalary();
              });
            }
          },
        ),
        ElevatedButton(
          onPressed: hasError ? null : _submit,
          child: Text('Добавить'),
        ),
      ],
    );
  }

  void _submit() {
    if (!_validateSalary()) {
      if (mounted) setState(() {});
      return;
    }

    context.router.pop(OfferStoryItemData(salary: salary));
  }

  bool _validateSalary() {
    if (salary <= 0) {
      salaryError = 'Значение должно быть больше 0';
      return false;
    }

    salaryError = null;
    return true;
  }
}
