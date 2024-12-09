import 'package:powersync/powersync.dart';

const assessmentQuestionsTable = Table('assessment_questions', [
  Column.text('assessment_id'),
  Column.text('question'),
  Column.text('question_type'),
  Column.text('min_words'),
  Column.integer('points'),
  Column.text('created_at'),
  Column.text('updated_at'),
]);
