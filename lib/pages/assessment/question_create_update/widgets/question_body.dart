import 'package:flutter/material.dart';
import 'package:school_erp/enums/question_type.dart';
import 'package:school_erp/pages/assessment/question_create_update/widgets/question_content/multiple_choice/multiple_choice.dart';
import 'package:school_erp/features/assessment/question_builder_bloc/question_builder_state.dart';

class AnswersBody extends StatelessWidget {
  final QuestionWithAnswers qa;

  const AnswersBody({
    super.key,
    required this.qa,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Content(
        qa: qa,
      ),
    );
  }
}

class Content extends StatelessWidget {
  final QuestionWithAnswers qa;

  const Content({
    super.key,
    required this.qa,
  });

  @override
  Widget build(BuildContext context) {
    switch (qa.question.questionType) {
      case QuestionType.multipleChoice:
        return MultipleChoiceContent(qa: qa);
      //case QuestionType.shortAnswer:
      //  return ShortAnswerContent(questionController: questionController);
      //case QuestionType.trueFalse:
      //  return TrueFalseContent(questionController: questionController);
      //case QuestionType.essay:
      //  return EssayContent(questionController: questionController);
      default:
        return const SizedBox();
    }
  }
}
