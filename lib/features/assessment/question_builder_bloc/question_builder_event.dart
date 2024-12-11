import 'package:school_erp/models/assessment_question.dart';

sealed class QuestionBuilderEvent {}

final class LoadQuestionsEvent extends QuestionBuilderEvent {}

final class LoadAnswersEvent extends QuestionBuilderEvent {
  final AssessmentQuestion question;

  LoadAnswersEvent({required this.question});
}

final class AddQuestionEvent extends QuestionBuilderEvent {
  final AssessmentQuestion question;

  AddQuestionEvent({
    required this.question,
  });
}

final class UpdateQuestionEvent extends QuestionBuilderEvent {
  final AssessmentQuestion question;

  UpdateQuestionEvent({
    required this.question,
  });
}
