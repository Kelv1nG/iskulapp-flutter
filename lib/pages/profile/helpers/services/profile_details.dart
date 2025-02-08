import 'package:school_erp/models/guardian.dart';
import 'package:school_erp/models/student.dart';
import 'package:school_erp/models/teacher.dart';
import 'package:school_erp/pages/profile/helpers/classes/student_profile_details.dart';
import 'package:school_erp/pages/profile/helpers/classes/teacher_profile_details.dart';
import 'package:school_erp/repositories/guardian_repository.dart';
import 'package:school_erp/repositories/student_repository.dart';
import 'package:school_erp/repositories/teacher_repository.dart';

StudentRepository studentRepository = StudentRepository();
GuardianRepository guardianRepository = GuardianRepository();
TeacherRepository teacherRepository = TeacherRepository();

class ProfileDetails {

    static Future<StudentProfileDetails> forStudent(userId, academicYearId) async {
        List<Guardian> guardiansOfStudent = await guardianRepository.getGuardiansOfStudent(userId: userId);
        Student studentDetails = await studentRepository.getStudentByUserIdAndAcademicYearById(userId: userId, academicYearId: academicYearId);

        StudentProfileDetails studentProfileDetails = StudentProfileDetails(studentDetails: studentDetails, guardiansOfStudent: guardiansOfStudent);

        return studentProfileDetails;
    }

    static  Future<TeacherProfileDetails>forTeacher(userId) async {
        Teacher teacherDetails = await teacherRepository.getTeacherByUserId(userId: userId);

        TeacherProfileDetails teacherProfileDetails = TeacherProfileDetails(teacherDetails: teacherDetails);
        return teacherProfileDetails;
    }
}