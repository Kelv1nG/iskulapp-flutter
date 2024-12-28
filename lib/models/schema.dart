import 'package:powersync/powersync.dart';
import 'package:school_erp/models/tables/assessment_question_answers_table.dart';
import 'package:school_erp/models/tables/student_sections.dart';
import 'package:school_erp/models/tables/students_table.dart';
import './tables/tables.dart';

Schema schema = const Schema(
  [
    assessmentsTable,
    assessmentTakersTable,
    assessmentQuestionsTable,
    assessmentQuestionAnswersTable,
    attendancesTable,
    academicYearsTable,
    sectionsTable,
    subjectYearsTable,
    subjectsTable,
    subjectClassesTable,
    studentsTable,
    studentSectionsTable,
    teachersTable,
    teacherYearTable,
    teacherSubjectsTable,
    userProfilesTable,
  ],
);
