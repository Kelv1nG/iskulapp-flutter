import 'package:powersync/powersync.dart';
import './tables/tables.dart';

Schema schema = const Schema(
  [
    assessmentsTable,
    assessmentTakersTable,
    attendancesTable,
    academicYearsTable,
    guardiansTable,
    guardianStudentTable,
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
