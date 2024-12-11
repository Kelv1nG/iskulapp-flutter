import 'package:flutter/material.dart';
import 'package:school_erp/features/assessment/question_builder_bloc/question_builder_bloc.dart';
import 'package:school_erp/features/assessment/question_builder_bloc/question_builder_event.dart';
import 'package:school_erp/features/assessment/question_builder_bloc/question_builder_state.dart';
import 'package:school_erp/models/assessment_question_answer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/pages/assessment/question_create_update/widgets/question_content/widgets/action_button.dart';
import 'package:school_erp/pages/assessment/question_create_update/widgets/question_content/widgets/answer_container.dart';
import 'package:school_erp/pages/common_widgets/custom_snackbar.dart';

class MultipleChoiceContent extends StatelessWidget {
  final QuestionWithAnswers qa;

  const MultipleChoiceContent({required this.qa, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: ListView.builder(
            itemCount: _choices.length,
            itemBuilder: (context, index) {
              return Text("hello");
              //return AnswerField(index: index, answer: _choices[index]);
            },
          ),
        ),
        const SizedBox(height: 16),
        ActionButton(onPressed: _showAnswerModal, text: "Next"),
      ],
    );
  }

  @override
  void _showAnswerModal() {
    //List<String> nonEmptyChoices =
    //    _choices.where((choice) => choice.isNotEmpty).toList();
    //
    //if (widget.questionController.text.isEmpty) {
    //  showCustomSnackbar(context, 'No Question Provided');
    //  return;
    //} else if (nonEmptyChoices.isEmpty) {
    //  showCustomSnackbar(
    //    context,
    //    'Please add at least one choice before providing an answer.',
    //  );
    //  return;
    //}
    //
    //final modal = MultipleChoiceAnswerModal(
    //  context: context,
    //  choices: nonEmptyChoices,
    //);
    //modal.show();
  }

  void showCustomSnackbar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => CustomSnackbar(message: message),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3)).then((_) {
      overlayEntry.remove();
    });
  }

  void _loadAnswers() async {
    if (!widget.qa.isAnswerFetched) {
      context
          .read<QuestionBuilderBloc>()
          .add(LoadAnswersEvent(question: widget.qa.question));
    }
    _choices = widget.qa.answers;
    print('this is the length');
    print(_choices.length);
  }
}
