import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';

class Guardian implements EntityDisplayData{
    final String id;
    final String userId;

    // from relation
    final String? firstName;
    final String? middleName;
    final String? lastName;

    Guardian({
        required this.id,
        required this.userId,
        this.firstName,
        this.middleName,
        this.lastName,
    });

    factory Guardian.fromRow(sqlite.Row row) => Guardian(
        id: row['id'],
        userId: row['user_id'],
        firstName: row['first_name'],
        middleName: row['middle_name'],
        lastName: row['last_name'],
    );

    @override
    String get displayName => "${lastName?.toUpperCase()}, ${firstName?.capitalize()} ${middleName != null ? '${middleName![0].toUpperCase() }.' : ''}";

    @override
    String get value => userId;
}
