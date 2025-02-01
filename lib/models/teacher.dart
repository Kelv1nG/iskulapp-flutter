import 'package:powersync/sqlite3_common.dart' as sqlite;

class Teacher {
    final String id;
    final String userId;
    final DateTime employedDate;
    final DateTime endDate;
    final String teacherNo;

    Teacher({
        required this.id,
        required this.userId,
        required this.employedDate,
        required this.endDate,
        required this.teacherNo
    });

    factory Teacher.fromRow(sqlite.Row row) => Teacher(
        id: row['id'],
        userId: row['user_id'],
        employedDate: row['employee_date'],
        endDate: row['end_date'],
        teacherNo: row['teacher_no']
    );
}
