import 'package:school_erp/models/base_model/base_model.dart';
import 'package:school_erp/enums/question_type.dart';
import 'package:powersync/sqlite3_common.dart' as sqlite;

class AssessmentQuestion extends BaseModel {
  final String assessmentId;
  final String question;
  final QuestionType questionType;
  final int points;
  final int? minWords;

  AssessmentQuestion({
    super.id,
    required this.assessmentId,
    required this.question,
    required this.questionType,
    required this.points,
    this.minWords,
  });

  AssessmentQuestion.initial({
    super.id,
    required this.assessmentId,
    required this.questionType,
    this.minWords,
    String? question,
    int? points,
  })  : points = points ?? 1,
        question = question ?? '';

  @override
  Map<String, dynamic> get tableData => {
        'id': id,
        'assessment_id': assessmentId,
        'question': question,
        'question_type': questionType.value,
        'points': points,
        'min_words': minWords,
      };

  factory AssessmentQuestion.fromRow(sqlite.Row row) => AssessmentQuestion(
        id: row['id'],
        assessmentId: row['assessment_id'],
        question: row['question'],
        questionType: row['question_type'],
        points: row['points'],
        minWords: row['min_words'],
      );

  AssessmentQuestion copyWith({
    String? question,
    QuestionType? questionType,
    int? points,
    int? minWords,
  }) {
    return AssessmentQuestion(
      assessmentId: assessmentId,
      question: question ?? this.question,
      questionType: questionType ?? this.questionType,
      points: points ?? this.points,
      minWords: minWords ?? this.minWords,
    );
  }
}
