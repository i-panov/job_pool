enum JobGrade { intern, junior, middle, senior, lead }

enum InterviewType {
  hr('с HR'),
  tech('техническое'),
  director('с руководителем');

  final String label;

  const InterviewType(this.label);
}

enum ContactType { email, phone, telegram, whatsapp, }

enum StoryItemType {
  interview('Собеседование'),
  waitingForFeedback('Ожидание фидбэка'),
  task('ТЗ'),
  failure('Провал'),
  offer('Оффер');

  final String label;
  
  const StoryItemType(this.label);
}
