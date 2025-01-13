import 'package:powersync/powersync.dart';

const studentsTable = Table('students', [
  Column.text('user_id'),
  Column.text('student_no'),
], indexes: [
  Index('user_id', [IndexedColumn('user_id')])
]);
