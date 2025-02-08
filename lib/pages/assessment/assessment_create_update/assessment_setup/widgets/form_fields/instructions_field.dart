import 'package:flutter/material.dart';
import 'package:school_erp/features/assessment/cubit/assessment_cubit.dart';
import 'package:school_erp/features/assessment/cubit/assessment_state.dart';
import 'package:school_erp/constants/assessments/form_labels.dart' as form;
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructionsField extends StatelessWidget {
  final AssessmentState state;

  const InstructionsField(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: state.assessment.instructions,
      maxLength: 120,
      decoration: const InputDecoration(
        labelText: form.instructionLabel,
      ),
      onSaved: (value) {
        context
            .read<AssessmentCubit>()
            .updateAssessment(state.assessment.copyWith(instructions: value!));
      },
    );
  }
}
