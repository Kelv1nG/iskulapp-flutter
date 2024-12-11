import 'package:school_erp/models/assessment_question.dart';
import 'package:school_erp/models/assessment_question_answer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_builder_state.freezed.dart';

enum QuestionBuilderStateStatus { initial, staging, success, failure }

@freezed
class QuestionBuilderState with _$QuestionBuilderState {
  const factory QuestionBuilderState({
    required String assessmentId,
    @Default([]) List<QuestionWithAnswers> questionsWithAnswers,
    @Default(QuestionBuilderStateStatus.initial)
    QuestionBuilderStateStatus status,
    String? errorMessage,
  }) = _QuestionBuilderState;

  factory QuestionBuilderState.initial({
    required String assessmentId,
  }) {
    return QuestionBuilderState(assessmentId: assessmentId);
  }
}

class QuestionWithAnswers {
  AssessmentQuestion question;
  List<AssessmentQuestionAnswer> answers;
  bool isAnswerFetched;

  QuestionWithAnswers({
    required this.question,
    required this.answers,
    bool? isAnswerFetched,
  }) : isAnswerFetched = isAnswerFetched ?? false;
}
