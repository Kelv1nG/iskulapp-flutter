import 'package:powersync/powersync.dart';
import 'package:school_erp/features/assessment/service_result_types/assessment_question_result.dart';
import 'package:school_erp/features/powersync/db.dart' as ps;
import 'package:school_erp/repositories/assessment_question_answer_repository.dart';
import 'package:school_erp/repositories/assessment_question_repository.dart';
import 'package:school_erp/models/assessment_question.dart';
import 'package:school_erp/models/assessment_question_answer.dart';

class QuestionBuilderService {
  final PowerSyncDatabase db;
  final AssessmentQuestionRepository assessmentQuestionRepository;
  final AssessmentQuestionAnswerRepository assessmentQuestionAnswerRepository;

  QuestionBuilderService([PowerSyncDatabase? database])
      : db = database ?? ps.db,
        assessmentQuestionRepository =
            AssessmentQuestionRepository(database: database ?? ps.db),
        assessmentQuestionAnswerRepository =
            AssessmentQuestionAnswerRepository(database: database ?? ps.db);

  Future<AssessmentQuestionWithAnswersCreateResult> create({
    required AssessmentQuestion question,
    required List<AssessmentQuestionAnswer> answers,
  }) async {
    final result = await db.writeTransaction((tx) async {
      final questionCreated =
          await assessmentQuestionRepository.create(question, tx: tx);

      final answersWithQuestionId = answers
          .map((answer) => answer.copyWith(questionId: questionCreated.id!))
          .toList();

      final answersCreated = await assessmentQuestionAnswerRepository
          .bulkCreate(answersWithQuestionId, tx: tx);

      return AssessmentQuestionWithAnswersCreateResult(
          question: questionCreated, answers: answersCreated);
    });
    return result;
  }

  Future<AssessmentQuestionWithAnswersUpdateResult> update({
    required AssessmentQuestion question,
    required List<AssessmentQuestionAnswer> answers,
    required List<AssessmentQuestionAnswer> answersForRemoval,
  }) async {
    AssessmentQuestion questionUpdated;
    var answersUpdated = <AssessmentQuestionAnswer>[];
    var answerIdsRemoved = <String>[];

    final result = await db.writeTransaction((tx) async {
      questionUpdated =
          await assessmentQuestionRepository.update(question, tx: tx);

      if (answers.isNotEmpty) {
        final updatedAnswers = answers
            .map((answer) => answer.copyWith(questionId: question.id!))
            .toList();

        answersUpdated = await assessmentQuestionAnswerRepository
            .bulkUpsert(updatedAnswers, tx: tx);
      }

      if (answersForRemoval.isNotEmpty) {
        answerIdsRemoved = await assessmentQuestionAnswerRepository
            .delete(answersForRemoval, tx: tx);
      }

      return AssessmentQuestionWithAnswersUpdateResult(
        question: questionUpdated,
        answers: answersUpdated,
        answerIdsRemoved: answerIdsRemoved,
      );
    });

    return result;
  }
}
