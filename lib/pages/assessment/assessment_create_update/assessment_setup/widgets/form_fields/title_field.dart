import 'package:flutter/material.dart';
import 'package:school_erp/constants/assessments/form_labels.dart' as form;
import 'package:school_erp/constants/assessments/form_validation.dart'
    as validation;
import 'package:school_erp/features/assessment/cubit/assessment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/features/assessment/cubit/assessment_cubit.dart';

class TitleField extends StatelessWidget {
  final AssessmentState state;
  final int maxLength;

  const TitleField(
    this.state, {
    this.maxLength = 30,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: state.assessment.title,
      maxLength: maxLength,
      decoration: const InputDecoration(
        hintText: form.titleTextHint,
        labelText: form.titleLabel,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validation.emptyTitle;
        }
        return null;
      },
      onChanged: (value) {
        context.read<AssessmentCubit>().updateAssessment(
              state.assessment.copyWith(title: value),
            );
      },
    );
  }
}
