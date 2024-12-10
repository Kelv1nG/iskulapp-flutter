import 'package:powersync/powersync.dart';
import 'package:school_erp/models/tables/assessment_question_answers_table.dart';

import './tables/tables.dart';

Schema schema = const Schema(
  [
    assessmentsTable,
    assessmentTakersTable,
    assessmentQuestionsTable,
    assessmentQuestionAnswersTable,
    academicYearsTable,
    sectionsTable,
    subjectYearsTable,
    subjectsTable,
    subjectClassesTable,
    teachersTable,
    teacherYearTable,
    teacherSubjectsTable,
  ],
);
