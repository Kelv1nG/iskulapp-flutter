import 'package:flutter/material.dart';
import 'package:school_erp/enums/assignment_type.dart';
import 'package:school_erp/constants/assessments/form_labels.dart' as form;
import 'package:school_erp/constants/assessments/form_validation.dart'
    as validation;

class AssignmentTypeField extends StatelessWidget {
  const AssignmentTypeField({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<AssignmentType>(
      value: AssignmentType.inApp,
      items: AssignmentType.values.map((AssignmentType assignmentType) {
        return DropdownMenuItem<AssignmentType>(
          value: assignmentType,
          child: Text(assignmentType.displayName),
        );
      }).toList(),
      onChanged: (newValue) {},
      decoration: const InputDecoration(
        labelText: form.typeLabel,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
      validator: (value) {
        if (value == null) {
          return validation.emptyType;
        }
        return null;
      },
    );
  }
}
