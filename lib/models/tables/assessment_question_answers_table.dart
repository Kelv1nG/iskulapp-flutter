import 'package:powersync/powersync.dart';

const assessmentQuestionAnswersTable = Table('assessment_question_answers', [
  Column.text('assessment_id'),
  Column.text('question_id'),
  Column.text('answer'),
  Column.integer('is_correct'),
  Column.text('created_at'),
  Column.text('updated_at'),
]);
