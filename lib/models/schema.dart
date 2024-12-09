import 'package:powersync/powersync.dart';

import './tables/tables.dart';

Schema schema = const Schema(
  [
    assessmentsTable,
    assessmentTakersTable,
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
