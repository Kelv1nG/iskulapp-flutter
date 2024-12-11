import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/features/assessment/question_builder_bloc/question_builder_event.dart';
import 'package:school_erp/features/assessment/question_builder_bloc/question_builder_state.dart';
import 'package:school_erp/features/assessment/services/question_builder_service.dart';

class QuestionBuilderBloc
    extends Bloc<QuestionBuilderEvent, QuestionBuilderState> {
  final QuestionBuilderService questionBuilderService;

  QuestionBuilderBloc(
      {required this.questionBuilderService, required String assessmentId})
      : super(QuestionBuilderState.initial(assessmentId: assessmentId)) {
    on<LoadQuestionsEvent>(_onLoadQuestionEvent);
    on<LoadAnswersEvent>(_onLoadAnswersEvent);
  }

  Future<void> _onLoadQuestionEvent(
    LoadQuestionsEvent event,
    Emitter<QuestionBuilderState> emit,
  ) async {
    var questions = await questionBuilderService.assessmentQuestionRepository
        .getByAssessment(state.assessmentId);

    var questionsWithAnswers = questions
        .map(
          (question) => QuestionWithAnswers(
            question: question,
            answers: [],
          ),
        )
        .toList();

    emit(
      state.copyWith(questionsWithAnswers: questionsWithAnswers),
    );
  }

  Future<void> _onLoadAnswersEvent(
    LoadAnswersEvent event,
    Emitter<QuestionBuilderState> emit,
  ) async {
    var answers = await questionBuilderService
        .assessmentQuestionAnswerRepository
        .getByQuestion(event.question.id!);

    var updatedQuestionsWithAnswers = state.questionsWithAnswers.map((qwa) {
      if (qwa.question.id == event.question.id) {
        return QuestionWithAnswers(
          question: qwa.question,
          answers: answers,
          isAnswerFetched: true,
        );
      }
      return qwa;
    }).toList();

    emit(
      state.copyWith(questionsWithAnswers: updatedQuestionsWithAnswers),
    );
  }
}
