import 'package:school_erp/models/guardian.dart';
import 'package:school_erp/models/student.dart';
import 'package:school_erp/models/teacher.dart';
import 'package:school_erp/repositories/guardian_repository.dart';
import 'package:school_erp/repositories/student_repository.dart';
import 'package:school_erp/repositories/teacher_repository.dart';

class GetProfileDetails {
    static Future<Map<String, dynamic>> forStudent(userId, academicYearId) async {
        StudentRepository studentRepository = StudentRepository();
        GuardianRepository guardianRepository = GuardianRepository();

        List<Guardian> guardiansOfStudent = await guardianRepository.getGuardiansOfStudent(userId: userId);
        Student studentDetails = await studentRepository.getStudent(userId: userId, academicYearId: academicYearId);

        return {
            "studentDetails": studentDetails,
            "guardiansOfStudent": guardiansOfStudent
        };
    }

    static Future<Map<String, dynamic>> forTeacher(userId) async {
        TeacherRepository teacherRepository = TeacherRepository();
        Teacher teacherDetails = await teacherRepository.getTeacher(userId: userId);
        return {
            "teacherDetails": teacherDetails
        };
    }
}