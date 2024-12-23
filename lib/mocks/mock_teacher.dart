import 'package:school_erp/interfaces/display_values.dart';

class MockTeacher implements DisplayValues{
    final String id;
    final String firstName;
    final String lastName;
    final String sectionId;

    MockTeacher({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.sectionId
    });

    factory MockTeacher.fromJson(Map<String, dynamic> json) {
        return MockTeacher(
            id: json['id'] ?? '', 
            firstName: json['first_name'] ?? '', 
            lastName: json['last_name'] ?? '', 
            sectionId: json['section_id'] ?? ''
        );
    }

    @override
    String get value => id;

    @override
    String get displayName => "$firstName $lastName";
}