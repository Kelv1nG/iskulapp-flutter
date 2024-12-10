import 'package:school_erp/models/assessment_question.dart';
import 'package:school_erp/models/tables/assessment_questions_table.dart';
import 'package:school_erp/repositories/base_crud_repository/base_crud_repository.dart';
import 'package:school_erp/utils/sql_statements.dart';

class AssessmentQuestionRepository
    extends BaseCrudRepository<AssessmentQuestion> {
  AssessmentQuestionRepository({super.database})
      : super(
          table: assessmentQuestionsTable,
          fromRow: AssessmentQuestion.fromRow,
        );

  Future<List<AssessmentQuestion>> getByAssessment(String assessmentId) async {
    var results =
        await database.execute(questionsByAssessmentSql, [assessmentId]);

    if (results.isEmpty) {
      return [];
    }

    return results.map(AssessmentQuestion.fromRow).toList(growable: false);
  }
}
