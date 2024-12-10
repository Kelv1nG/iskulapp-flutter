import 'package:school_erp/models/base_model/base_model.dart';
import 'package:powersync/sqlite3_common.dart' as sqlite;

class AssessmentQuestionAnswer extends BaseModel {
  final String assessmentId;
  final String? questionId;
  final String answer;
  final bool isCorrect;

  AssessmentQuestionAnswer._({
    super.id,
    required this.assessmentId,
    this.questionId,
    required this.answer,
    required this.isCorrect,
  });

  factory AssessmentQuestionAnswer({
    String? id,
    required String assessmentId,
    required String? questionId,
    required String answer,
    required bool isCorrect,
  }) {
    return AssessmentQuestionAnswer._(
      id: id,
      assessmentId: assessmentId,
      questionId: questionId,
      answer: answer,
      isCorrect: isCorrect,
    );
  }

  factory AssessmentQuestionAnswer.initialize({
    required String assessmentId,
    required String questionId,
  }) {
    return AssessmentQuestionAnswer._(
      assessmentId: assessmentId,
      questionId: questionId,
      answer: '',
      isCorrect: false,
    );
  }

  @override
  Map<String, dynamic> get tableData => {
        'id': id,
        'assessment_id': assessmentId,
        'question_id': questionId,
        'answer': answer,
        'isCorrect': isCorrect,
      };

  factory AssessmentQuestionAnswer.fromRow(sqlite.Row row) =>
      AssessmentQuestionAnswer(
        id: row['id'],
        assessmentId: row['assessment_id'],
        questionId: row['question_id'],
        answer: row['answer'],
        isCorrect: (row['is_correct'] == 1),
      );

  AssessmentQuestionAnswer copyWith({
    String? questionId,
    String? answer,
    bool? isCorrect,
  }) {
    return AssessmentQuestionAnswer._(
      id: id,
      assessmentId: assessmentId,
      questionId: questionId ?? this.questionId,
      answer: answer ?? this.answer,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}
