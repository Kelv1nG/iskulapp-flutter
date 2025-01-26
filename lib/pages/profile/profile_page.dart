import 'package:flutter/cupertino.dart';
import 'package:school_erp/enums/user_role.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/models/academic_year.dart';
import 'package:school_erp/models/guardian.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/models/student.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/profile/helpers/classes/profile_item_data.dart';
import 'package:school_erp/pages/profile/widgets/profile_details_list.dart';
import 'package:school_erp/pages/profile/widgets/profile_header.dart';
import 'package:school_erp/repositories/academic_year_repository.dart';
import 'package:school_erp/repositories/guardian_repository.dart';
import 'package:school_erp/repositories/sections_repository.dart';
import 'package:school_erp/repositories/student_repository.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';

class ProfilePage extends StatefulWidget {
    const ProfilePage({super.key});

    @override
    createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    late final AuthenticatedUser user;
    late final Section section;
    late final List<Guardian> guardians;
    late final AcademicYear academicYear;
    late final Student student;

    @override
    void initState() {
        super.initState();

        _getUserDetails();
        if (user.role == UserRole.student) _getStudentProfileDetails();
    }

    void _getUserDetails() {
        AuthenticatedUser authUser = getAuthUser(context);
        setState(() => user = authUser);
    }

    void _getStudentProfileDetails() async {
        StudentRepository studentRepository = StudentRepository();
        SectionRepository sectionRepository = SectionRepository();
        GuardianRepository guardianRepository = GuardianRepository();
        AcademicYearRepository academicYearRepository =AcademicYearRepository();
        List<Section> sectionOfStudent = await sectionRepository.getSectionOfStudent(userId: user.id);
        List<Guardian> guardiansOfStudent = await guardianRepository.getGuardiansOfStudent(userId: user.id);
        AcademicYear academicYearOfStudent = await academicYearRepository.getAcademicYearOfStudent(academicYearId: user.academicYearId);
        Student studentDetails = await studentRepository.getStudent(userId: user.id);

        setState(() {
                // Get first row here instead of doing it in getSectionOfStudent.
                // getSectionOfStudent may also be modified to query for past sections of student
                section = sectionOfStudent[0];
                guardians = guardiansOfStudent;
                academicYear = academicYearOfStudent;
                student = studentDetails;
            });
    }

    @override
    Widget build(BuildContext context) {
        final List<ProfileItemData> profileItemDataList = [
            ProfileItemData('Student No.', student.studentNo),
            ProfileItemData('Academic Year', '${academicYear.start} - ${academicYear.end}'),
            ProfileItemData('Grade Level', section.gradeLevelName!.capitalize(), CupertinoIcons.lock_fill),
            ProfileItemData('Section', section.displayName, CupertinoIcons.lock_fill),
            ProfileItemData('Date of Birth', '22 July 1996', CupertinoIcons.lock_fill),
            ProfileItemData('Permanent Address', 'Karol Bagh, Delhi', CupertinoIcons.lock_fill, 370),
            ProfileItemData('Guardian Email', 'parentboth84@gmail.com', CupertinoIcons.lock_fill, 370),
        ];

        for (int i = 0; i < guardians.length; i++) {
            profileItemDataList.add(
                ProfileItemData(
                    'Guardian ${i + 1}', 
                    guardians[i].displayName, 
                    CupertinoIcons.lock_fill, 
                    370
                )
            );
        }

        return DefaultLayout(
            title: 'My Profile',
            content: [
                Expanded(
                    flex: 2,
                    child: ProfileHeader(user: user)
                ),
                Expanded(
                    flex: 8,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10), 
                        child: ProfileDetailsList(items: profileItemDataList)
                    )
                ),
            ],
        );
    }
}
