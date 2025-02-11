import 'package:flutter/material.dart';
import 'package:school_erp/features/assessment/cubit/assessment_cubit.dart';
import 'package:school_erp/features/assessment/cubit/assessment_state.dart';
import 'package:school_erp/models/subject_year.dart';
import 'package:school_erp/constants/assessments/form_labels.dart' as form;
import 'package:school_erp/constants/assessments/form_validation.dart'
    as validation;
import 'package:school_erp/utils/extensions/string_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectField extends StatelessWidget {
  final AssessmentState state;
  final List<SubjectYear> activeSubjects;

  const SubjectField({
    super.key,
    required this.state,
    required this.activeSubjects,
  });

  @override
  Widget build(BuildContext context) {
    final selectedSubjectYear = state.assessment.subjectYearId == null
        ? null
        : activeSubjects.firstWhere(
            (subjectYear) => subjectYear.id == state.assessment.subjectYearId,
          );

    return DropdownButtonFormField<SubjectYear?>(
      value: selectedSubjectYear,
      items: activeSubjects.map((SubjectYear? subjectYear) {
        return DropdownMenuItem<SubjectYear?>(
          value: subjectYear,
          child: Text(subjectYear?.subjectName?.title() ?? ''),
        );
      }).toList(),
      onChanged: (SubjectYear? newValue) {
        context.read<AssessmentCubit>().updateAssessment(
              state.assessment.copyWith(
                subjectYearId: newValue?.id ?? '',
              ),
            );
      },
      decoration: const InputDecoration(
        labelText: form.subjectLabel,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
      validator: (value) {
        if (value == null) {
          return validation.emptySubject;
        }
        return null;
      },
    );
  }
}
