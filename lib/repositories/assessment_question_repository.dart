import 'package:school_erp/models/assessment_questions.dart';
import 'package:school_erp/models/tables/assessment_questions_table.dart';
import 'package:school_erp/repositories/base_crud_repository/base_crud_repository.dart';

class AssessmentQuestionRepository
    extends BaseCrudRepository<AssessmentQuestion> {
  AssessmentQuestionRepository({super.database})
      : super(
          table: assessmentQuestionsTable,
          fromRow: AssessmentQuestion.fromRow,
        );
}
