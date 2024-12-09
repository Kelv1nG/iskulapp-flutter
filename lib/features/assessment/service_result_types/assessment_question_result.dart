import 'package:school_erp/models/assessment_question.dart';
import 'package:school_erp/models/assessment_question_answer.dart';

final class AssessmentQuestionWithAnswersCreateResult {
  final AssessmentQuestion question;
  final List<AssessmentQuestionAnswer> answers;

  AssessmentQuestionWithAnswersCreateResult({
    required this.question,
    required this.answers,
  });
}

final class AssessmentQuestionWithAnswersUpdateResult {
  final AssessmentQuestion question;
  final List<AssessmentQuestionAnswer> answers;
  final List<String> answerIdsRemoved;

  AssessmentQuestionWithAnswersUpdateResult({
    required this.question,
    required this.answers,
    required this.answerIdsRemoved,
  });
}
