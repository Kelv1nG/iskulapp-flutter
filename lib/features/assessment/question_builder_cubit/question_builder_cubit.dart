import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/enums/action_type.dart';
import 'package:school_erp/enums/question_type.dart';
import 'package:school_erp/features/assessment/question_builder_cubit/question_builder_state.dart';
import 'package:school_erp/features/assessment/services/question_builder_service.dart';
import 'package:school_erp/models/assessment_question.dart';
import 'package:school_erp/models/assessment_question_answer.dart';

class QuestionBuilderCubit extends Cubit<QuestionBuilderState> {
  final QuestionBuilderService _questionBuilderService;

  QuestionBuilderCubit({
    required QuestionBuilderService questionBuilderService,
    required String assessmentId,
    AssessmentQuestion? question,
  })  : _questionBuilderService = questionBuilderService,
        super(QuestionBuilderState.initial(
          assessmentId: assessmentId,
          existingQuestion: question,
        )) {
    _loadQuestionAnswers();
  }

  void updateQuestion(AssessmentQuestion question) {
    emit(
      state.copyWith(
        question: question,
        status: QuestionBuilderStateStatus.staging,
      ),
    );
  }

  void addAnswer() {
    var newAnswer = AssessmentQuestionAnswer.initialize(
      assessmentId: state.question.assessmentId,
      questionId: state.question.id!,
    );
    emit(
      state.copyWith(
        answers: [...state.answers, newAnswer],
        status: QuestionBuilderStateStatus.staging,
      ),
    );
  }

  void updateAnswer(int index, AssessmentQuestionAnswer answer) {
    final updatedAnswers = List<AssessmentQuestionAnswer>.from(state.answers);
    updatedAnswers[index] = answer;

    emit(
      state.copyWith(
        answers: updatedAnswers,
        status: QuestionBuilderStateStatus.staging,
      ),
    );
  }

  void updateAnswersForRemoval(int index) {
    if (index < 0 || index >= state.answers.length) {
      return;
    }

    final answerToRemove = state.answers[index];

    final updatedAnswersForRemoval =
        List<AssessmentQuestionAnswer>.from(state.answersForRemoval)
          ..add(answerToRemove);

    final updatedAnswers = List<AssessmentQuestionAnswer>.from(state.answers)
      ..removeAt(index);

    emit(
      state.copyWith(
        answers: updatedAnswers,
        answersForRemoval: updatedAnswersForRemoval,
        status: QuestionBuilderStateStatus.staging,
      ),
    );
  }

  void save() async {
    if (state.status == QuestionBuilderStateStatus.staging) {
      if (state.question.id == null && state.actionType == ActionType.update) {
        throw StateError('Question ID is required for update operation');
      }

      _validateAnswers();

      try {
        switch (state.actionType) {
          case ActionType.create:
            await _questionBuilderService.create(
              question: state.question,
              answers: state.answers,
            );
            emit(state.copyWith(
              status: QuestionBuilderStateStatus.success,
            ));
            break;

          case ActionType.update:
            await _questionBuilderService.update(
              question: state.question,
              answers: state.answers,
              answersForRemoval: state.answersForRemoval,
            );
            emit(state.copyWith(
              status: QuestionBuilderStateStatus.success,
            ));
            break;

          default:
            emit(state.copyWith(
              status: QuestionBuilderStateStatus.failure,
              errorMessage: 'Invalid action type',
            ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: QuestionBuilderStateStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  void _validateAnswers() {
    switch (state.question.questionType) {
      case QuestionType.multipleChoice:
        if (state.answers.isEmpty) {
          throw StateError(
              'Multiple choice questions must have at least one answer');
        }
        break;
      case QuestionType.trueFalse:
        if (state.answers.length != 2) {
          throw StateError(
              'True/False questions must have exactly two answers');
        }
        break;
      case QuestionType.shortAnswer:
        if (state.answers.isNotEmpty) {
          throw StateError(
              'Short answer questions should not have predefined answers');
        }
        break;
      default:
        break;
    }
  }

  Future<void> _loadQuestionAnswers() async {
    try {
      if (state.actionType == ActionType.update && state.question.id != null) {
        final existingAnswers = await _questionBuilderService
            .assessmentQuestionAnswerRepository
            .getByQuestion(state.question.id!);

        emit(
          state.copyWith(
            answers: existingAnswers,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: QuestionBuilderStateStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
