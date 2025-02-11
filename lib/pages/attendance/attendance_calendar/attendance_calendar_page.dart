import 'package:flutter/material.dart';
import 'package:school_erp/enums/filter_by_type.dart';
import 'package:school_erp/enums/user_role.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/schemas.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/features/powersync/sync_check_mixin.dart';
import 'package:school_erp/models/attendance.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/models/student.dart';
import 'package:school_erp/enums/attendance_status.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_calendar.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_filters.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/helpers/attendance_calendar_utils.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/common_widgets/loading/syncing_progress.dart';
import 'package:school_erp/repositories/attendance_repository.dart';
import 'package:school_erp/repositories/sections_repository.dart';
import 'package:school_erp/repositories/student_repository.dart';
import 'package:school_erp/theme/colors.dart';

class AttendanceCalendarPage extends StatefulWidget {
  const AttendanceCalendarPage({super.key});

  @override
  createState() => _AttendanceCalendarPageState();
}

class _AttendanceCalendarPageState extends State<AttendanceCalendarPage>
    with SyncStatusCheck {
  final _firstDay = DateTime.utc(2000, 1, 1);
  final _lastDay = DateTime.now();
  var _focusedDay = DateTime.now();

  AuthenticatedUser? user;
  SectionRepository sectionRepository = SectionRepository();
  StudentRepository studentRepository = StudentRepository();
  AttendanceRepository attendanceRepository = AttendanceRepository();

  List<Section> sectionsOfTeacher = [];
  List<Student> students = [];
  List<Attendance> attendanceStudent = [];

  Section? currentSection;
  List<Attendance> attendanceOfDateRange = [];

  // Converted List<Attendance> to map for ease of access of data.
  Map<DateTime, Attendance> attendanceDetails = {};

  FilterByType? filterBy;
  List<FilterByType> filters = FilterByType.values;

  final Map<String, bool> _loadingStates = {
    "isSectionsLoading": false,
    "isStudentsLoading": false,
    "isStudentAttendanceLoading": false
  };

  @override
  void initState() {
    super.initState();
    syncingCheck(() {
      _getUserDetails();
      if (user?.role == UserRole.teacher) _getSectionsOfTeacher();
      if (user?.role == UserRole.student) _getStudentAttendance();
    });
  }

  void _getUserDetails() {
    AuthenticatedUser authUser = getAuthUser(context);
    setState(() => user = authUser);
  }

  void _getStudentAttendance() async {
    try {
      setState(() => _loadingStates["isStudentAttendanceLoading"] = true);

      List<Attendance> studentAttendance =
          await attendanceRepository.getStudentAttendance(user!.id);

      if (studentAttendance.isEmpty) throw Exception("No attendance record.");

      setState(() => attendanceDetails =
          AttendanceCalendarUtils.convertAttendanceDetails(studentAttendance));
    }
    // Handle better in the future.
    catch (error) {
      print(error);
    } finally {
      setState(() => _loadingStates["isStudentAttendanceLoading"] = false);
    }
  }

  void _getSectionsOfTeacher() async {
    try {
      setState(() => _loadingStates["isSectionsLoading"] = true);

      String teacherId = getTeacherId(context);

      List<Section> responseSections =
          await sectionRepository.getTeacherSectionsAll(
              teacherId: teacherId, academicYearId: user!.academicYearId);

      if (responseSections.isEmpty)
        throw Exception("Teacher has no sections handled.");

      setState(() => sectionsOfTeacher = responseSections);
    }
    // Handle better in the future.
    catch (error) {
      print(error);
    } finally {
      setState(() => _loadingStates["isSectionsLoading"] = false);
    }
  }

  void _onChangeFocusedDate(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
  }

  void _onChangeSection(Section newSection) async {
    try {
      setState(() => _loadingStates["isStudentsLoading"] = true);

      List<Student> studentsOfSection =
          await studentRepository.getStudentsBySection(newSection.id);
      List<Attendance> attendanceOfStudents = await attendanceRepository
          .getStudentsAttendanceBySection(sectionId: newSection.id);

      if (studentsOfSection.isEmpty)
        throw Exception("No students in ths section.");
      if (attendanceOfStudents.isEmpty) attendanceOfStudents = [];

      studentsOfSection.sort((a, b) =>
          a.lastName!.toLowerCase().compareTo(b.lastName!.toLowerCase()));

      setState(() {
        filterBy = null;
        currentSection = newSection;
        attendanceStudent = attendanceOfStudents;
        students = studentsOfSection;
        attendanceDetails = {};
      });
    }
    // Handle better in the future.
    catch (error) {
      print(error);
    } finally {
      setState(() => _loadingStates["isStudentsLoading"] = false);
    }
  }

  void _onChangeStudent(Student? student) {
    if (student == null) {
      return setState(() => attendanceDetails = {});
    }
    List<Attendance> studentAttendanceRecord = attendanceStudent
        .where((attendance) => attendance.studentId == student.id)
        .toList();
    return setState(() => attendanceDetails =
        AttendanceCalendarUtils.convertAttendanceDetails(
            studentAttendanceRecord));
  }

  void _onChangeFilterBy(FilterByType? filter) {
    setState(() {
      filterBy = filter;
      attendanceDetails = {};
    });
  }

  void _onChangeFilterRange(DateTimeRange dateTimeRange) {
    setState(
        () => attendanceOfDateRange = attendanceStudent.where((attendance) {
              return attendance.attendanceDate.isAfter(dateTimeRange.start) &&
                  attendance.attendanceDate.isBefore(dateTimeRange.end);
            }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "Attendance",
      content: [
        Expanded(
          child: !synced
              ? const Center(child: SyncingProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AttendanceCalendarUtils.buildStatus(
                              context,
                              AttendanceStatus.present.displayName,
                              AppColors.presentColor,
                              false),
                          AttendanceCalendarUtils.buildStatus(
                              context,
                              AttendanceStatus.late.displayName,
                              AppColors.lateColor,
                              false),
                          AttendanceCalendarUtils.buildStatus(
                              context,
                              AttendanceStatus.absent.displayName,
                              AppColors.absentColor,
                              false),
                          AttendanceCalendarUtils.buildStatus(
                              context,
                              AttendanceStatus.authorizedAbsence.displayName,
                              AppColors.leaveColor,
                              false),
                        ],
                      ),
                    ),
                    if (filterBy == FilterByType.student &&
                            currentSection != null ||
                        user?.role == UserRole.student &&
                            !_loadingStates["isStudentAttendanceLoading"]!)
                      AttendanceCalendar(
                        details: attendanceDetails,
                        firstDay: _firstDay,
                        lastDay: _lastDay,
                        focusedDay: _focusedDay,
                        onChangeFocusedDate: _onChangeFocusedDate,
                      ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Expanded(
                      child: AttendanceFilters(
                        role: user?.role,
                        changeStudentFilter: _onChangeStudent,
                        changeSectionFilter: _onChangeSection,
                        changeFilterBy: _onChangeFilterBy,
                        changeDateRange: _onChangeFilterRange,
                        attendance: attendanceStudent,
                        attendanceOfRange: attendanceOfDateRange,
                        students: students,
                        filters: filters,
                        sections: sectionsOfTeacher,
                        isLoading: _loadingStates,
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
