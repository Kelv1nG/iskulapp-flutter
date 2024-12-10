import 'package:school_erp/models/assessment_question_answer.dart';
import 'package:school_erp/models/tables/assessment_question_answers_table.dart';
import 'package:school_erp/repositories/base_crud_repository/base_crud_repository.dart';
import 'package:school_erp/utils/sql_statements.dart';

class AssessmentQuestionAnswerRepository
    extends BaseCrudRepository<AssessmentQuestionAnswer> {
  AssessmentQuestionAnswerRepository({super.database})
      : super(
          table: assessmentQuestionAnswersTable,
          fromRow: AssessmentQuestionAnswer.fromRow,
        );

  Future<List<AssessmentQuestionAnswer>> getByQuestion(
    String questionId,
  ) async {
    var results = await database.execute(answersByQuestionSql, [questionId]);

    if (results.isEmpty) {
      return [];
    }

    return results
        .map(AssessmentQuestionAnswer.fromRow)
        .toList(growable: false);
  }
}
