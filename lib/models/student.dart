import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';

class Student implements EntityDisplayData{
    final String id;
    final String userId;
    final String studentNo;

    // from relation
    final String? firstName;
    final String? middleName;
    final String? lastName;
    final String? sectionId;
    final String? sectionName;
    final String? gradeLevelId;
    final String? gradeLevelName;
    final String? gender;
    final String? academicYearName;
    final int? academicYearStart;
    final int? academicYearEnd;
    final String? schoolId;
    final DateTime? birthDate;
    final String? address;

    Student({
        required this.id,
        required this.userId,
        required this.studentNo,
        this.firstName,
        this.middleName,
        this.lastName,
        this.sectionId,
        this.sectionName,
        this.gradeLevelId,
        this.gradeLevelName,
        this.gender,
        this.academicYearName,
        this.academicYearStart,
        this.academicYearEnd,
        this.schoolId,
        this.birthDate,
        this.address,
    });

    factory Student.fromRow(sqlite.Row row) => Student(
        id: row['id'],
        userId: row['user_id'],
        studentNo: row['student_no'],
        firstName: row['first_name'],
        middleName: row['middle_name'],
        lastName: row['last_name'],
        sectionId: row['section_id'],
        sectionName: row['section_name'],
        gradeLevelId: row['grade_level_id'],
        gradeLevelName: row['grade_level_name'],
        gender: row['gender'],
        academicYearName: row['academic_year_name'],
        academicYearStart: DateTime.parse(row['academic_year_start']).year,
        academicYearEnd: DateTime.parse(row['academic_year_end']).year,
        schoolId: row['school_id'],
        birthDate: DateTime.parse(row['birth_date']),
        address: row['address'],
    );

    @override
    String get displayName => "${lastName?.toUpperCase()}, ${firstName?.capitalize()} ${middleName != null ? '${middleName![0].toUpperCase() }.' : ''}";

    @override
    String get value => userId;
}
