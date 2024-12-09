enum QuestionType {
  multipleChoice('multiple_choice', 'Multiple Choice'),
  trueFalse('true_or_false', 'True or False'),
  shortAnswer('short_answer', 'Short Answer'),
  essay('essay', 'Essay');

  final String value;
  final String displayName;

  const QuestionType(this.value, this.displayName);

  static QuestionType fromString(String value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () =>
          throw ArgumentError('Invalid AssessmentStatus value: $value'),
    );
  }

  static QuestionType fromDisplayName(String displayName) {
    return values.firstWhere(
      (v) => v.displayName.toLowerCase() == displayName.toLowerCase(),
      orElse: () => throw ArgumentError(
          'Invalid AssessmentStatus display name: $displayName'),
    );
  }
}
