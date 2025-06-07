import 'package:flutter/material.dart';
import 'package:job_pool/core/theme_utils.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';

class GradeChip extends StatefulWidget {
  final JobGrade grade;

  const GradeChip({
    super.key,
    required this.grade,
  });

  @override
  State<GradeChip> createState() => _GradeChipState();
}

class _GradeChipState extends State<GradeChip> {
  bool isHovered = false;

  String get tooltipText => switch (widget.grade) {
    JobGrade.intern => 'Стажер - начинающий специалист без опыта',
    JobGrade.junior => 'Junior - специалист с небольшим опытом',
    JobGrade.middle => 'Middle - опытный специалист',
    JobGrade.senior => 'Senior - ведущий специалист',
    JobGrade.lead => 'Lead - руководитель команды',
  };

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Tooltip(
        message: tooltipText,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          child: Chip(
            backgroundColor: isHovered 
                ? GradeColors.primary[widget.grade]!.withAlpha(40)
                : GradeColors.backgroundFor(widget.grade),
            side: BorderSide(
              color: GradeColors.borderFor(widget.grade),
            ),
            avatar: Icon(
              GradeIcons.icons[widget.grade],
              size: 18,
              color: GradeColors.primary[widget.grade],
            ),
            label: Text(
              widget.grade.name,
              style: TextStyle(
                color: GradeColors.primary[widget.grade],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DirectionChip extends StatefulWidget {
  final String name;

  const DirectionChip({
    super.key,
    required this.name,
  });

  @override
  State<DirectionChip> createState() => _DirectionChipState();
}

class _DirectionChipState extends State<DirectionChip> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        child: Chip(
          backgroundColor: isHovered 
              ? DirectionColors.text(Theme.of(context)).withAlpha(40)
              : DirectionColors.background(Theme.of(context)),
          side: BorderSide(
            color: DirectionColors.border(Theme.of(context)),
          ),
          label: Text(
            widget.name,
            style: TextStyle(
              color: DirectionColors.text(Theme.of(context)),
            ),
          ),
        ),
      ),
    );
  }
}