import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/features/attendance/cubit/attendance_check_cubit.dart';
import 'package:school_erp/features/attendance/cubit/attendance_check_state.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/pages/attendance/attendance_create_update/widgets/attendance_check_item.dart';
import 'package:school_erp/pages/common_widgets/dividers/general_divider.dart';

class AttendanceCheckList extends StatelessWidget {
  final DateTime? date;
  final Section? section;
  const AttendanceCheckList({
    required this.section,
    required this.date,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceCheckCubit, AttendanceCheckState>(
      buildWhen: (previous, current) {
        return previous.attendanceList != current.attendanceList;
      },
      listenWhen: (previous, current) {
        return current.status == AttendanceCheckStatus.failure;
      },
      listener: (context, state) {
        if (state.status == AttendanceCheckStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
          );
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AttendanceCheckListHeader(),
            Divider(
              color: Colors.grey.shade300,
              height: 0,
              thickness: 1,
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.attendanceList.length,
                separatorBuilder: (context, index) => Column(
                  children: [
                    const SizedBox(height: 2),
                    GeneralDivider(
                      symmetricDividerSpaceHeight: 0.25,
                      dividerColor: Colors.grey.shade300,
                    ),
                  ],
                ),
                itemBuilder: (context, idx) {
                  return AttendanceCheckItem(index: idx);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class AttendanceCheckListHeader extends StatelessWidget {
  const AttendanceCheckListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Student",
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "Late",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Absent",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Present",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
