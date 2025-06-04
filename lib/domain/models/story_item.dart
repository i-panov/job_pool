import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:job_pool/data/storage/db/db.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/data/storage/schemas/story_items.dart';

extension StoryItemDtoExtension on StoryItemDto {
  StoryItem toDomain() => switch (type) {
    StoryItemType.interview => InterviewStoryItem(
      id: id,
      vacancyId: vacancy,
      createdAt: createdAt,
      time: commonTime!,
      isOnline: interviewIsOnline!,
      target: interviewTarget,
      type: interviewType!,
    ),
    StoryItemType.waitingForFeedback => WaitingForFeedbackStoryItem(
      id: id,
      vacancyId: vacancy,
      createdAt: createdAt,
      time: commonTime!,
      comment: commonComment,
    ),
    StoryItemType.task => TaskStoryItem(
      id: id,
      vacancyId: vacancy,
      createdAt: createdAt,
      link: taskLink,
      deadline: taskDeadline!,
    ),
    StoryItemType.failure => FailureStoryItem(
      id: id,
      vacancyId: vacancy,
      createdAt: createdAt,
      comment: commonComment,
    ),
    StoryItemType.offer => OfferStoryItem(
      id: id,
      vacancyId: vacancy,
      createdAt: createdAt,
      salary: offerSalary!,
    ),
  };
}

sealed class StoryItem extends Equatable {
  final int id, vacancyId;
  final DateTime createdAt;

  const StoryItem({
    required this.id,
    required this.vacancyId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, vacancyId, createdAt];

  IconData get icon {
    return switch (this) {
      InterviewStoryItem() => Icons.calendar_today,
      WaitingForFeedbackStoryItem() => Icons.hourglass_top,
      TaskStoryItem() => Icons.assignment,
      FailureStoryItem() => Icons.cancel,
      OfferStoryItem() => Icons.work,
    };
  }

  Color get color {
    return switch (this) {
      InterviewStoryItem() => Colors.blue,
      WaitingForFeedbackStoryItem() => Colors.orange,
      TaskStoryItem() => Colors.purple,
      FailureStoryItem() => Colors.red,
      OfferStoryItem() => Colors.green,
    };
  }

  StoryItemDto toDto() => StoryItemDto(
    id: id,
    vacancy: vacancyId,
    createdAt: createdAt,
    type: switch (this) {
      InterviewStoryItem() => StoryItemType.interview,
      WaitingForFeedbackStoryItem() => StoryItemType.waitingForFeedback,
      TaskStoryItem() => StoryItemType.task,
      FailureStoryItem() => StoryItemType.failure,
      OfferStoryItem() => StoryItemType.offer,
    },
    commonTime: switch (this) {
      InterviewStoryItem(: final time) => time,
      WaitingForFeedbackStoryItem(: final time) => time,
      _ => null,
    },
    commonComment: switch (this) {
      WaitingForFeedbackStoryItem(comment: final comment) => comment,
      FailureStoryItem(: final comment) => comment,
      _ => '',
    },
    interviewIsOnline: switch (this) {
      InterviewStoryItem(: final isOnline) => isOnline,
      _ => null,
    },
    interviewTarget: switch (this) {
      InterviewStoryItem(: final target) => target,
      _ => '',
    },
    interviewType: switch (this) {
      InterviewStoryItem(: final type) => type,
      _ => null,
    },
    taskLink: switch (this) {
      TaskStoryItem(: final link) => link,
      _ => '',
    },
    taskDeadline: switch (this) {
      TaskStoryItem(: final deadline) => deadline,
      _ => null,
    },
    offerSalary: switch (this) {
      OfferStoryItem(: final salary) => salary,
      _ => null,
    },
  );
}

class InterviewStoryItem extends StoryItem {
  final DateTime time;
  final bool isOnline;
  final String target;
  final InterviewTypes type;

  const InterviewStoryItem({
    required super.id,
    required super.vacancyId,
    required super.createdAt,
    required this.time,
    required this.isOnline,
    required this.target,
    required this.type,
  });

  @override
  List<Object?> get props => [...super.props, time, isOnline, target, type];
}

class WaitingForFeedbackStoryItem extends StoryItem {
  final DateTime time;
  final String comment;

  const WaitingForFeedbackStoryItem({
    required super.id,
    required super.vacancyId,
    required super.createdAt,
    required this.time,
    required this.comment,
  });

  @override
  List<Object?> get props => [...super.props, time, comment];
}

class TaskStoryItem extends StoryItem {
  final DateTime deadline;
  final String link;

  const TaskStoryItem({
    required super.id,
    required super.vacancyId,
    required super.createdAt,
    required this.deadline,
    required this.link,
  });

  @override
  List<Object?> get props => [...super.props, deadline, link];
}

class FailureStoryItem extends StoryItem {
  final String comment;

  const FailureStoryItem({
    required super.id,
    required super.vacancyId,
    required super.createdAt,
    required this.comment,
  });

  @override
  List<Object?> get props => [...super.props, comment];
}

class OfferStoryItem extends StoryItem {
  final int salary;

  const OfferStoryItem({
    required super.id,
    required super.vacancyId,
    required super.createdAt,
    required this.salary,
  });

  @override
  List<Object?> get props => [...super.props, salary];
}
