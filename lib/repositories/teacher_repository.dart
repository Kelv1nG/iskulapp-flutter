import 'package:school_erp/models/tables/tables.dart';
import 'package:school_erp/models/teacher.dart';
import 'package:school_erp/repositories/base_repository/read_only_repository.dart';
import 'package:school_erp/utils/sql_statements.dart';

class TeacherRepository extends ReadOnlyRepository<Teacher> {
    TeacherRepository({super.database})
        : super(table: teachersTable, fromRow: Teacher.fromRow);

    Future<Teacher> getTeacherByUserId({
        required String userId,
    }) async {
        var result = await database.execute(
            teacherSql,
            [userId]
        );

        return Teacher.fromRow(result.first);
    }
}
