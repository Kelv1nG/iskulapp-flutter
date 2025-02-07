import 'package:school_erp/models/guardian.dart';
import 'package:school_erp/models/student.dart';

class StudentProfileDetails {
    Student studentDetails;
    List<Guardian> guardiansOfStudent;

    StudentProfileDetails({
        required this.studentDetails, 
        required this.guardiansOfStudent
    });
}