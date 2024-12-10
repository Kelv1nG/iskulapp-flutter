import 'package:school_erp/enums/action_type.dart';
import 'package:school_erp/enums/question_type.dart';
import 'package:school_erp/models/assessment_question.dart';
import 'package:school_erp/models/assessment_question_answer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_builder_state.freezed.dart';

enum QuestionBuilderStateStatus { initial, staging, success, failure }

@freezed
class QuestionBuilderState with _$QuestionBuilderState {
  const factory QuestionBuilderState({
    required String assessmentId,
    required AssessmentQuestion question,
    required ActionType actionType,
    @Default([]) List<AssessmentQuestionAnswer> answers,
    @Default([]) List<AssessmentQuestionAnswer> answersForRemoval,
    @Default(QuestionBuilderStateStatus.initial)
    QuestionBuilderStateStatus status,
    String? errorMessage,
  }) = _QuestionBuilderState;

  factory QuestionBuilderState.initial({
    required String assessmentId,
    AssessmentQuestion? existingQuestion,
  }) {
    return QuestionBuilderState(
      assessmentId: assessmentId,
      question: existingQuestion ??
          AssessmentQuestion.initial(
            assessmentId: assessmentId,
            questionType: QuestionType.multipleChoice,
          ),
      actionType:
          existingQuestion != null ? ActionType.update : ActionType.create,
    );
  }
}
