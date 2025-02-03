import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:school_erp/enums/user_role.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/models/academic_year.dart';
import 'package:school_erp/models/guardian.dart';
import 'package:school_erp/models/student.dart';
import 'package:school_erp/models/teacher.dart';
import 'package:school_erp/pages/common_widgets/animation_widgets/loading_overlay.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/profile/helpers/classes/profile_item_data.dart';
import 'package:school_erp/pages/profile/widgets/profile_details_list.dart';
import 'package:school_erp/pages/profile/widgets/profile_header.dart';
import 'package:school_erp/repositories/guardian_repository.dart';
import 'package:school_erp/repositories/student_repository.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';

class ProfilePage extends StatefulWidget {
    const ProfilePage({super.key});

    @override
    createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    AuthenticatedUser? user;
    List<Guardian>? guardians;
    AcademicYear? academicYear;
    Student? student;
    Teacher? teacher;
    bool _isLoading = true;

    @override
    void initState() {
        super.initState();

        _getUserDetails();
        if (user?.role == UserRole.student) _getStudentProfileDetails();
    }

    void _getUserDetails() {
        AuthenticatedUser authUser = getAuthUser(context);
        setState(() => user = authUser);
    }

    void _getStudentProfileDetails() async {
        try {
            setState(() => _isLoading = true);

            StudentRepository studentRepository = StudentRepository();
            GuardianRepository guardianRepository = GuardianRepository();
            List<Guardian> guardiansOfStudent = await guardianRepository.getGuardiansOfStudent(userId: user!.id);
            Student studentDetails = await studentRepository.getStudent(userId: user!.id, academicYearId: user!.academicYearId);

            setState(() {
                    guardians = guardiansOfStudent;
                    student = studentDetails;
                });
        } catch (e) {
            print(e);
        } finally {
            setState(() => _isLoading = false);
        }
    }

    @override
    Widget build(BuildContext context) {
        // START OF STUDENT DETAILS -------------------------------------------------
        final List<ProfileItemData> studentItemDataList = 
            // Show a blank list if _isLoading to avoid bugs, and errors caused by displaying
            // data without actual data. 
            // Can also instead display somehting else for each field (like Loading...) if deisred instead of this apporach
            _isLoading ? []
                : [
                    ProfileItemData('Student No.', student!.studentNo),
                    ProfileItemData('Academic Year', '${student!.academicYearStart} - ${student!.academicYearEnd}'),
                    ProfileItemData('Grade Level', student!.gradeLevelName!.title(), CupertinoIcons.lock_fill),
                    ProfileItemData('Section', student!.sectionName!.title(), CupertinoIcons.lock_fill),
                    ProfileItemData('Date of Birth', DateFormat('dd MMM, yyyy').format(student!.birthDate!), CupertinoIcons.lock_fill),
                    ProfileItemData('Permanent Address', student!.address!.title(), CupertinoIcons.lock_fill, 370),
                    ProfileItemData('Guardian Email', guardians![0].email!, CupertinoIcons.lock_fill, 370),
                ];

        if (!_isLoading) {for (int i = 0; i < guardians!.length; i++) {
                studentItemDataList.add(
                    ProfileItemData(
                        'Guardian ${i + 1}', 
                        guardians![i].displayName, 
                        CupertinoIcons.lock_fill, 
                        370
                    )
                );
            }}

        // END OF STUDENT DETAILS ---------------------------------------------------

        // START OF TEACHER DETAILS -------------------------------------------------
        final List<ProfileItemData> teacherItemDataList = 
            // Show a blank list if _isLoading to avoid bugs, and errors caused by displaying
            // data without actual data. 
            // Can also instead display somehting else for each field (like Loading...) if deisred instead of this apporach
            _isLoading ? []
                : [
                    ProfileItemData('Teacher No.', teacher!.teacherNo),
                    ProfileItemData('Email', user!.email),
                ];

        // END OF TEACHER DETAILS ---------------------------------------------------

        // Needs to be inside build method to access ItemDatalists.
        List<ProfileItemData> detailsToBeDisplayed(UserRole role) {
            if (role == UserRole.student) studentItemDataList;
            return teacherItemDataList;
        }

        return Stack(
            children: [
                DefaultLayout(
                    title: 'My Profile',
                    content: [
                        Expanded(
                            flex: 2,
                            child: ProfileHeader(user: user!),
                        ),
                        Expanded(
                            flex: 8,
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: ProfileDetailsList(items: detailsToBeDisplayed(user!.role)),
                            ),
                        ),
                    ],
                ),
                if (_isLoading) LoadingOverlay(),

            ],
        );
    }
}
