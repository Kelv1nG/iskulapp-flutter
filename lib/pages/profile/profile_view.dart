import 'package:flutter/material.dart';
import 'package:school_erp/enums/user_role.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/features/powersync/sync_check_mixin.dart';
import 'package:school_erp/models/academic_year.dart';
import 'package:school_erp/models/guardian.dart';
import 'package:school_erp/models/student.dart';
import 'package:school_erp/models/teacher.dart';
import 'package:school_erp/pages/common_widgets/loading/syncing_progress.dart';
import 'package:school_erp/pages/profile/helpers/classes/student_profile_details.dart';
import 'package:school_erp/pages/profile/helpers/classes/teacher_profile_details.dart';
import 'package:school_erp/pages/profile/helpers/services/profile_details.dart';
import 'package:school_erp/pages/profile/widgets/profile_header.dart';
import 'package:school_erp/pages/profile/widgets/student_details.dart';
import 'package:school_erp/pages/profile/widgets/teacher_details.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SyncStatusCheck {
  AuthenticatedUser? user;
  List<Guardian>? guardians;
  AcademicYear? academicYear;
  Student? student;
  Teacher? teacher;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    syncingCheck(() {
      _getUserDetails();
      _getProfileDetails();
    });
  }

  void _getUserDetails() {
    AuthenticatedUser authUser = getAuthUser(context);
    setState(() => user = authUser);
  }

  void _getProfileDetails() async {
    try {
      if (user?.role == UserRole.student) {
        StudentProfileDetails studentProfileDetails =
            await ProfileDetails.forStudent(user!.id, user!.academicYearId);

        setState(() {
          guardians = studentProfileDetails.guardiansOfStudent;
          student = studentProfileDetails.studentDetails;
        });
      }

      if (user?.role == UserRole.teacher) {
        TeacherProfileDetails teacherProfileDetails =
            await ProfileDetails.forTeacher(user!.id);

        setState(() => teacher = teacherProfileDetails.teacherDetails);
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!synced) {
      return const Center(child: SyncingProgressIndicator());
    }

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Expanded(
      child: Column(
        children: [
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
          )
        ],
      ),
    );
  }
}
