import 'package:flutter/material.dart';
import 'package:school_erp/models/assessment_question_answer.dart';
import 'package:school_erp/pages/assessment/question_create_update/widgets/question_content/widgets/add_item_button.dart';

class AnswerField extends StatelessWidget {
  final int index;
  final AssessmentQuestionAnswer answer;

  const AnswerField({required this.index, required this.answer, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: answer.answer,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Choice ${String.fromCharCode(65 + index)}',
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          AddRemoveItemButton(
            index: index,
            onAddPressed: () {},
            onRemovePressed: () {},
          ),
        ],
      ),
    );
  }
}
