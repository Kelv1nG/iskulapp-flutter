import 'package:school_erp/models/assessment_question_answers.dart';
import 'package:school_erp/models/tables/assessment_question_answers_table.dart';
import 'package:school_erp/repositories/base_crud_repository/base_crud_repository.dart';

class AssessmentQuestionAnswerRepository
    extends BaseCrudRepository<AssessmentQuestionAnswer> {
  AssessmentQuestionAnswerRepository({super.database})
      : super(
          table: assessmentQuestionAnswersTable,
          fromRow: AssessmentQuestionAnswer.fromRow,
        );
}
