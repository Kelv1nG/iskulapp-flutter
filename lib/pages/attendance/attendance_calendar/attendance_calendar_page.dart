import 'package:flutter/material.dart';
import 'package:school_erp/enums/filter_by_type.dart';
import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/mocks/mock_section.dart';
import 'package:school_erp/mocks/mock_student.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/classes/attendance_details.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/enums/attendance_status.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_calendar.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_filters.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/helpers/attendance_calendar_services.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/theme/colors.dart';

// For testing only. 
// Remove and replace with proper thing after.
enum Roles {student, teacher, parent}

class AttendanceCalendarPage extends StatefulWidget{

    const AttendanceCalendarPage({super.key});

    @override
    createState() => _AttendanceCalendarPageState();
}

class _AttendanceCalendarPageState extends State<AttendanceCalendarPage> {
    late DateTime _firstDay;
    late DateTime _lastDay;
    late DateTime _focusedDay;
    // final Map<DateTime, DateDetails> _details = {};

    // For testing purposes with teacher.json
    MockSection? currentSection;

    // For testing purposes with students.json
    List<MockStudent> students = [];

    // For testing purposes with attendance.json
    List<AttendanceDetails> attendanceStudent = [];

    List<AttendanceDetails> attendanceOfDateRange = [];

    // For testing purposes for attendance for each person
    Map<DateTime, AttendanceDetails> attendanceDetails = {};

    EntityDisplayData? filterBy;
    List<EntityDisplayData> filters = FilterByType.values.toList();

    @override
    void initState() {
        super.initState();
        _firstDay = DateTime.utc(2000, 1, 1); 
        _lastDay = DateTime.now(); 
        _focusedDay = DateTime.now(); 
    }

    void _onChangeFocusedDate(DateTime selectedDay, DateTime focusedDay) {
        setState(() {
                _focusedDay = focusedDay;
            }
        );
    }

    void _onChangeSection(MockSection newSection) async {
        List<AttendanceDetails> attendanceForSection = await AttendanceCalendarServices.loadStudentAttendance(newSection);
        List<MockStudent> studentsOfSection = await AttendanceCalendarServices.loadStudentsOfSection(newSection);

        setState(() {
                filterBy = null;
                currentSection = newSection;
                attendanceStudent = attendanceForSection;
                students = studentsOfSection;
                attendanceDetails = {};
            });
    }

    void _onChangePerson(EntityDisplayData? person) {
        if (person == null) {
            return setState(() => attendanceDetails = {});
        }
        if (person is MockStudent) {
            List<AttendanceDetails> studentAttendanceRecord = attendanceStudent.where((attendance) => attendance.studentId == person.id).toList();
            return setState(() => attendanceDetails = ConvertedAttendanceDetails.fromAttendanceList(studentAttendanceRecord).dateDetails);
        }
    }

    void _onChangeFilterBy(FilterByType? filter) {
        setState(() {
                filterBy = filter;
                attendanceDetails = {}; 
            });
    }

    void _onChangeFilterRange(DateTimeRange dateTimeRange) {
        setState(() =>
            attendanceOfDateRange = attendanceStudent.where((attendance) {
                    return attendance.attendanceDate.isAfter(dateTimeRange.start) && attendance.attendanceDate.isBefore(dateTimeRange.end);
                }).toList()
        );
    }

    Widget _buildLegend(String legendText, Color legendColor) {
        return Row(
            children: [
                Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: legendColor,
                        shape: BoxShape.circle,
                    ),
                    child: SizedBox.shrink()
                ),
                SizedBox(width: 3),
                Text(legendText)
            ],
        );
    }

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: "Attendance", 
            content: [
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            _buildLegend(AttendanceStatus.present.displayName, AppColors.presentColor),
                            _buildLegend(AttendanceStatus.late.displayName, AppColors.lateColor),
                            _buildLegend(AttendanceStatus.absent.displayName, AppColors.absentColor),
                            _buildLegend(AttendanceStatus.leave.displayName, AppColors.leaveColor),
                        ],
                    ),
                ),

                if (filterBy == FilterByType.student && currentSection != null) 
                AttendanceCalendar(
                    details: attendanceDetails,
                    firstDay: _firstDay, 
                    lastDay: _lastDay,  
                    focusedDay: _focusedDay,
                    onChangeFocusedDate: _onChangeFocusedDate,
                ), 
                AttendanceFilters(
                    // This role is only for testing/development purposes
                    role: Roles.teacher, 
                    changePersonFilter: _onChangePerson,
                    changeSectionFilter: _onChangeSection,
                    changeFilterBy: _onChangeFilterBy,
                    changeDateRange: _onChangeFilterRange,
                    attendance: attendanceStudent,
                    attendanceOfRange: attendanceOfDateRange,
                    students: students,
                    filters: filters,
                ),
            ]
        );
    }
}

