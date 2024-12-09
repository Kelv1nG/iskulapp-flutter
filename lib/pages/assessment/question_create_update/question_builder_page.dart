import 'package:flutter/material.dart';
import 'package:school_erp/enums/question_type.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import './widgets/widgets.dart';

class QuestionBuilderPage extends StatelessWidget {
  const QuestionBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuestionBuilderView();
  }
}

class QuestionBuilderView extends StatelessWidget {
  const QuestionBuilderView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Question Builder',
      content: const [PaginatedFormContent()],
    );
  }
}

class PaginatedFormContent extends StatefulWidget {
  const PaginatedFormContent({super.key});

  @override
  _FormContentState createState() => _FormContentState();
}

class _FormContentState extends State<PaginatedFormContent> {
  QuestionType _questionType = QuestionType.multipleChoice;
  final TextEditingController _questionController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controller to avoid memory leaks
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          QuestionTypeSection(
            questionType: _questionType,
            onQuestionTypeChanged: (QuestionType? newValue) {
              setState(() {
                _questionType = newValue!;
              });
            },
          ),
          Question(questionController: _questionController),
          QuestionBody(
            questionController: _questionController,
            questionType: _questionType,
          ),
        ],
      ),
    );
  }
}
