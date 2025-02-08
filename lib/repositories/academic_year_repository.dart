import 'package:school_erp/models/academic_year.dart';
import 'package:school_erp/models/tables/tables.dart';
import 'package:school_erp/repositories/base_repository/read_only_repository.dart';
import 'package:school_erp/utils/sql_statements.dart';

class AcademicYearRepository extends ReadOnlyRepository<AcademicYear> {
    AcademicYearRepository({super.database})
        : super(table: academicYearsTable, fromRow: AcademicYear.fromRow);

    // Check uniformity of this. with object as a parameter with required or not.
    Future<AcademicYear?> getAcademicYearOfStudent({ 
        required String academicYearId,
    }) async {
        var results = await database.execute(
            academicYearsOfStudent,
            [academicYearId],
        );

        if (results.isEmpty) return null;

        return AcademicYear.fromRow(results.first);
    }
}
