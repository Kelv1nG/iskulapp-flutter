import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/enums/question_type.dart';
import 'package:school_erp/features/assessment/assessment_cubit/assessment_cubit.dart';
import 'package:school_erp/features/assessment/question_builder_bloc/question_builder_bloc.dart';
import 'package:school_erp/features/assessment/question_builder_bloc/question_builder_event.dart';
import 'package:school_erp/features/assessment/question_builder_bloc/question_builder_state.dart';
import 'package:school_erp/features/assessment/services/question_builder_service.dart';
import 'package:school_erp/pages/assessment/question_create_update/widgets/question.dart';
import 'package:school_erp/pages/assessment/question_create_update/widgets/question_body.dart';
import 'package:school_erp/pages/assessment/question_create_update/widgets/question_type_section.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/common_widgets/helper_widgets/pagination/pagination.dart';

class QuestionBuilderPage extends StatelessWidget {
  const QuestionBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final assessment = context.read<AssessmentCubit>().state.assessment;

    return BlocProvider<QuestionBuilderBloc>(
      create: (BuildContext context) {
        final questionBuilderService = QuestionBuilderService();
        return QuestionBuilderBloc(
          assessmentId: assessment.id!,
          questionBuilderService: questionBuilderService,
        )..add(LoadQuestionsEvent());
      },
      child: QuestionBuilderView(),
    );
  }
}

class QuestionBuilderView extends StatelessWidget {
  const QuestionBuilderView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Question Builder',
      content: const [QuestionsPaginated()],
    );
  }
}

class QuestionsPaginated extends StatelessWidget {
  const QuestionsPaginated({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBuilderBloc, QuestionBuilderState>(
        builder: (context, state) {
      return Pagination<QuestionWithAnswers>(
          listOfData: state.questionsWithAnswers,
          itemsPerPage: 1,
          isLoading: false,
          itemBuilder: (BuildContext context, QuestionWithAnswers qa) {
            return QuestionContent(qa: qa);
          });
    });
  }
}

class QuestionContent extends StatelessWidget {
  final QuestionWithAnswers qa;

  const QuestionContent({required this.qa, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        QuestionTypeSection(
          questionType: qa.question.questionType,
          onQuestionTypeChanged: (QuestionType? newValue) {
            print('question type');
          },
        ),
        QuestionBody(qa: qa),
        AnswersBody(
          qa: qa,
        ),
      ],
    );
  }
}
