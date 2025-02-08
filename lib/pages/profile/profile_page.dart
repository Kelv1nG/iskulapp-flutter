import 'package:flutter/cupertino.dart';
import 'package:school_erp/enums/user_role.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/models/academic_year.dart';
import 'package:school_erp/models/guardian.dart';
import 'package:school_erp/models/student.dart';
import 'package:school_erp/models/teacher.dart';
import 'package:school_erp/pages/common_widgets/animation_widgets/loading_overlay.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/profile/helpers/classes/student_profile_details.dart';
import 'package:school_erp/pages/profile/helpers/classes/teacher_profile_details.dart';
import 'package:school_erp/pages/profile/helpers/services/profile_details.dart';
import 'package:school_erp/pages/profile/widgets/profile_header.dart';
import 'package:school_erp/pages/profile/widgets/student_details.dart';
import 'package:school_erp/pages/profile/widgets/teacher_details.dart';

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
        _getProfileDetails();
    }

    void _getUserDetails() {
        AuthenticatedUser authUser = getAuthUser(context);
        setState(() => user = authUser);
    }

    void _getProfileDetails() async {
        try {
            setState(() => _isLoading = true);

            if (user?.role == UserRole.student) {
                StudentProfileDetails studentProfileDetails = await ProfileDetails.forStudent(user!.id, user!.academicYearId);

                return setState(() {
                        guardians = studentProfileDetails.guardiansOfStudent;
                        student = studentProfileDetails.studentDetails;
                    });

            }

            if (user?.role == UserRole.teacher) {
                TeacherProfileDetails teacherProfileDetails = await ProfileDetails.forTeacher(user!.id);

                return setState(() => teacher = teacherProfileDetails.teacherDetails);
            }

        } catch (e) {
            print(e);
        } finally {
            setState(() => _isLoading = false);
        }
    }

    @override
    Widget build(BuildContext context) {
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
                                child: user?.role == UserRole.student 
                                    ? StudentDetails(student: student!, guardians: guardians!) 
                                    : TeacherDetails(user: user!, teacher: teacher!),
                            ),
                        ),
                    ],
                ),
                if (_isLoading) LoadingOverlay(),

            ],
        );
    }
}
