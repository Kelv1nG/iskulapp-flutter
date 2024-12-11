import 'package:flutter/material.dart';
import 'package:school_erp/features/assessment/question_builder_bloc/question_builder_state.dart';

class QuestionBody extends StatelessWidget {
  final QuestionWithAnswers qa;

  const QuestionBody({
    required this.qa,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: TextFormField(
        initialValue: qa.question.question,
        decoration: const InputDecoration(
          labelText: 'Question',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
