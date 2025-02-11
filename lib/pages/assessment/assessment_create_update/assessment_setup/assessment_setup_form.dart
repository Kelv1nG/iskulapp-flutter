import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/constants/assessments/form_validation.dart'
    as validation;
import 'package:school_erp/features/assessment/cubit/assessment_cubit.dart';
import 'package:school_erp/features/assessment/cubit/assessment_state.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/models/subject_year.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_setup/widgets/form_fields/assignment_type_field.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_setup/widgets/form_fields/instructions_field.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_setup/widgets/form_fields/subject_field.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_setup/widgets/form_fields/title_field.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/widgets/next_button.dart';
import 'package:school_erp/repositories/repositories.dart';
import 'package:school_erp/routes/routes.dart';
import 'package:go_router/go_router.dart';

class AssessmentSetupForm extends StatefulWidget {
  const AssessmentSetupForm({super.key});

  @override
  _AssessmentSetupFormState createState() => _AssessmentSetupFormState();
}

class _AssessmentSetupFormState extends State<AssessmentSetupForm> {
  final _formKey = GlobalKey<FormState>();
  late List<SubjectYear> _activeSubjects;
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubjectSelection();
  }

  void _loadSubjectSelection() async {
    final authUser = getAuthUser(context);
    final teacherId = getTeacherId(context);

    final subjects = await subjectYearRepository.getTeacherSubjects(
      teacherId: teacherId,
      academicYearId: authUser.academicYearId,
    );

    setState(() {
      _activeSubjects = subjects;
      _isLoading = false;
    });
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.push(
        assessmentTakersRoute.path,
        extra: BlocProvider.of<AssessmentCubit>(context),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(validation.unfilledFields)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentCubit, AssessmentState>(
      builder: (context, state) {
        if (_isLoading || state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleField(state),
                  const SizedBox(height: 25),
                  SubjectField(
                    activeSubjects: _activeSubjects,
                    state: state,
                  ),
                  const SizedBox(height: 25),
                  InstructionsField(state),
                  const SizedBox(height: 25),
                  AssignmentTypeField(),
                  const Spacer(),
                  NextButton(
                    onPressed: _validateAndSubmit,
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
