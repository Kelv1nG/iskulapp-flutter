import 'package:school_erp/models/guardian.dart';
import 'package:school_erp/models/tables/guardians_table.dart';
import 'package:school_erp/repositories/base_repository/read_only_repository.dart';
import 'package:school_erp/utils/sql_statements.dart';

class GuardianRepository extends ReadOnlyRepository<Guardian> {
    GuardianRepository({super.database})
        : super(table: guardiansTable, fromRow: Guardian.fromRow);

    // Check uniformity of this. with object as a parameter with required or not.
    Future<List<Guardian>> getGuardiansOfStudent({ 
        required String userId,
    }) async {
        var results = await database.execute(
            guardiansOfStudentSql,
            [userId],
        );

        if (results.isEmpty) {
            return [];
        }

        return results.map(Guardian.fromRow).toList(growable: false);
    }
}
