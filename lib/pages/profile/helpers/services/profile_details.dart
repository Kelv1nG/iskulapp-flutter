import 'package:school_erp/models/guardian.dart';
import 'package:school_erp/models/student.dart';
import 'package:school_erp/models/teacher.dart';
import 'package:school_erp/repositories/guardian_repository.dart';
import 'package:school_erp/repositories/student_repository.dart';
import 'package:school_erp/repositories/teacher_repository.dart';

StudentRepository studentRepository = StudentRepository();
GuardianRepository guardianRepository = GuardianRepository();
TeacherRepository teacherRepository = TeacherRepository();

class ProfileDetails {

    static Future<Map<String, dynamic>> forStudent(userId, academicYearId) async {
        List<Guardian> guardiansOfStudent = await guardianRepository.getGuardiansOfStudent(userId: userId);
        Student studentDetails = await studentRepository.getStudent(userId: userId, academicYearId: academicYearId);

        return {
            "studentDetails": studentDetails,
            "guardiansOfStudent": guardiansOfStudent
        };
    }

    static Future<Map<String, dynamic>> forTeacher(userId) async {
        Teacher teacherDetails = await teacherRepository.getTeacher(userId: userId);
        return {
            "teacherDetails": teacherDetails
        };
    }
}