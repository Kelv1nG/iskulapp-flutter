import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';

class AcademicYear extends EntityDisplayData{
    final int start;
    final int end;
    final String name;

    AcademicYear({
        required this.start,
        required this.end,
        required this.name,
    });

    factory AcademicYear.fromRow(sqlite.Row row) {
        return AcademicYear(
            start: DateTime.parse(row['start']).year,
            end: DateTime.parse(row['end']).year,
            name: row['name']);
    }

    @override
    String get displayName => name.capitalize();

    @override
    String get value => name;
}