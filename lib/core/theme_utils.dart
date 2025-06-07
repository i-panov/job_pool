import 'package:flutter/material.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/data/storage/schemas/story_items.dart';

class GradeColors {
  static const Map<JobGrade, Color> primary = {
    JobGrade.intern: Colors.grey,
    JobGrade.junior: Colors.green,
    JobGrade.middle: Colors.blue,
    JobGrade.senior: Colors.purple,
    JobGrade.lead: Colors.orange,
  };

  static Color backgroundFor(JobGrade grade) {
    return primary[grade]!.withAlpha(25);
  }

  static Color borderFor(JobGrade grade) {
    return primary[grade]!.withAlpha(50);
  }
}

class GradeIcons {
  static const Map<JobGrade, IconData> icons = {
    JobGrade.intern: Icons.school,
    JobGrade.junior: Icons.engineering,
    JobGrade.middle: Icons.psychology,
    JobGrade.senior: Icons.architecture,
    JobGrade.lead: Icons.group,
  };
}

class DirectionColors {
  static Color background(ThemeData theme) => theme.primaryColor.withAlpha(25);
  static Color border(ThemeData theme) => theme.primaryColor.withAlpha(50);
  static Color text(ThemeData theme) => theme.primaryColor;
}

class StoryItemStyle {
  static Color backgroundColor(StoryItemType type) => switch (type) {
    StoryItemType.interview => Colors.blue.shade50,
    StoryItemType.waitingForFeedback => Colors.orange.shade50,
    StoryItemType.task => Colors.purple.shade50,
    StoryItemType.failure => Colors.red.shade50,
    StoryItemType.offer => Colors.green.shade50,
  };

  static Color borderColor(StoryItemType type) => switch (type) {
    StoryItemType.interview => Colors.blue.shade200,
    StoryItemType.waitingForFeedback => Colors.orange.shade200,
    StoryItemType.task => Colors.purple.shade200,
    StoryItemType.failure => Colors.red.shade200,
    StoryItemType.offer => Colors.green.shade200,
  };

  static Color textColor(StoryItemType type) => switch (type) {
    StoryItemType.interview => Colors.blue.shade800,
    StoryItemType.waitingForFeedback => Colors.orange.shade800,
    StoryItemType.task => Colors.purple.shade800,
    StoryItemType.failure => Colors.red.shade800,
    StoryItemType.offer => Colors.green.shade800,
  };

  static Color labelColor = Colors.grey.shade700;
  static Color valueColor = Colors.grey.shade900;

  static IconData icon(StoryItemType type) => switch (type) {
    StoryItemType.interview => Icons.people,
    StoryItemType.waitingForFeedback => Icons.schedule,
    StoryItemType.task => Icons.assignment,
    StoryItemType.failure => Icons.close,
    StoryItemType.offer => Icons.check_circle,
  };
}