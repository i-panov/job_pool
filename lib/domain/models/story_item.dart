import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:job_pool/core/enums.dart';
import 'package:job_pool/data/db/db.dart';

extension StoryItemDtoExtension on StoryItemDto {
  StoryItem toDomain() {
    final data = switch (type) {
      StoryItemType.interview => InterviewStoryItemData(
        time: commonTime!,
        isOnline: interviewIsOnline!,
        target: interviewTarget,
        type: interviewType!,
      ),
      StoryItemType.waitingForFeedback => WaitingForFeedbackStoryItemData(
        time: commonTime!,
        comment: commonComment,
      ),
      StoryItemType.task => TaskStoryItemData(
        link: taskLink,
        deadline: taskDeadline!,
      ),
      StoryItemType.failure => FailureStoryItemData(comment: commonComment),
      StoryItemType.offer => OfferStoryItemData(salary: offerSalary!),
    };

    return StoryItem(
      id: id,
      vacancyId: vacancy,
      createdAt: createdAt,
      data: data,
    );
  }
}

class StoryItem<T extends StoryItemData> extends Equatable {
  final int id, vacancyId;
  final DateTime createdAt;
  final T data;

  const StoryItem({
    this.id = -1,
    this.vacancyId = -1,
    required this.createdAt,
    required this.data,
  });

  @override
  List<Object?> get props => [id, vacancyId, createdAt, data];

  StoryItemType get dtoType => switch (data) {
    InterviewStoryItemData() => StoryItemType.interview,
    WaitingForFeedbackStoryItemData() => StoryItemType.waitingForFeedback,
    TaskStoryItemData() => StoryItemType.task,
    FailureStoryItemData() => StoryItemType.failure,
    OfferStoryItemData() => StoryItemType.offer,
  };

  IconData get icon {
    return switch (data) {
      InterviewStoryItemData() => Icons.calendar_today,
      WaitingForFeedbackStoryItemData() => Icons.hourglass_top,
      TaskStoryItemData() => Icons.assignment,
      FailureStoryItemData() => Icons.cancel,
      OfferStoryItemData() => Icons.work,
    };
  }

  Color get color {
    return switch (data) {
      InterviewStoryItemData() => Colors.blue,
      WaitingForFeedbackStoryItemData() => Colors.orange,
      TaskStoryItemData() => Colors.purple,
      FailureStoryItemData() => Colors.red,
      OfferStoryItemData() => Colors.green,
    };
  }

  StoryItemDto toDto() => StoryItemDto(
    id: id,
    vacancy: vacancyId,
    createdAt: createdAt,
    type: dtoType,
    commonTime: switch (data) {
      InterviewStoryItemData(:final time) => time,
      WaitingForFeedbackStoryItemData(:final time) => time,
      _ => null,
    },
    commonComment: switch (data) {
      WaitingForFeedbackStoryItemData(comment: final comment) => comment,
      FailureStoryItemData(:final comment) => comment,
      _ => '',
    },
    interviewIsOnline: switch (data) {
      InterviewStoryItemData(:final isOnline) => isOnline,
      _ => null,
    },
    interviewTarget: switch (data) {
      InterviewStoryItemData(:final target) => target,
      _ => '',
    },
    interviewType: switch (data) {
      InterviewStoryItemData(:final type) => type,
      _ => null,
    },
    taskLink: switch (data) {
      TaskStoryItemData(:final link) => link,
      _ => '',
    },
    taskDeadline: switch (data) {
      TaskStoryItemData(:final deadline) => deadline,
      _ => null,
    },
    offerSalary: switch (data) {
      OfferStoryItemData(:final salary) => salary,
      _ => null,
    },
  );
}

sealed class StoryItemData extends Equatable {
  const StoryItemData();
}

class InterviewStoryItemData extends StoryItemData {
  final DateTime time;
  final bool isOnline;
  final String target;
  final InterviewType type;

  const InterviewStoryItemData({
    required this.time,
    required this.isOnline,
    required this.target,
    required this.type,
  });

  @override
  List<Object?> get props => [time, isOnline, target, type];
}

class WaitingForFeedbackStoryItemData extends StoryItemData {
  final DateTime time;
  final String comment;

  const WaitingForFeedbackStoryItemData({
    required this.time,
    required this.comment,
  });

  @override
  List<Object?> get props => [time, comment];
}

class TaskStoryItemData extends StoryItemData {
  final DateTime deadline;
  final String link;

  const TaskStoryItemData({required this.deadline, required this.link});

  @override
  List<Object?> get props => [deadline, link];
}

class FailureStoryItemData extends StoryItemData {
  final String comment;

  const FailureStoryItemData({required this.comment});

  @override
  List<Object?> get props => [comment];
}

class OfferStoryItemData extends StoryItemData {
  final int salary;

  const OfferStoryItemData({required this.salary});

  @override
  List<Object?> get props => [salary];
}
