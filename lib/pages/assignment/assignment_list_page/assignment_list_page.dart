import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/features/powersync/sync_check_mixin.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/pages/common_widgets/app_bar_widgets/add_button.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/common_widgets/helper_widgets/pagination/pagination.dart';
import 'package:school_erp/repositories/repositories.dart';
import 'package:school_erp/routes/routes.dart';
import 'widgets/assignment_card.dart';
import 'package:intl/intl.dart';

class AssignmentListPage extends StatefulWidget {
  const AssignmentListPage({super.key});

  @override
  createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage>
    with SyncStatusCheck {
  List<Assessment> _assessments = [];
  late StreamSubscription<List<Assessment>> _subscription;

  // Adjust number of rows to retreive on request
  final int _itemsPerPage = 10;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    syncingCheck(() => _watchAssessments());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _watchAssessments() async {
    final authUser = getAuthUser(context);
    final teacherId = getTeacherId(context);

    final stream = assessmentRepository.watchTeacherAssessments(
      teacherId: teacherId,
      assessmentType: AssessmentType.assignment,
      academicYearId: authUser.academicYearId,
    );

    _subscription = stream.listen((data) {
      if (!mounted) {
        return;
      }
      setState(() => (_assessments = data));
    });
  }

  String formatDate(DateTime date) => DateFormat('dd MMM yy').format(date);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "Assignments Page",
      trailingWidget: AppBarAddButton(
        path: assessmentSetupRoute.path,
        extra: {'assessmentTypeOnCreate': AssessmentType.assignment},
      ),
      content: [
        Pagination<Assessment>(
          listOfData: _assessments,
          itemsPerPage: _itemsPerPage,
          isLoading: _isLoading,
          itemBuilder: (BuildContext context, Assessment assessment) {
            return AssignmentCard(assessment: assessment);
          },
        )
      ],
    );
  }
}
