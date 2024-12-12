// ignore_for_file: non_constant_identifier_names

enum QuestionType  {
    multipleChoice('multipleChoice', 'Multiple Choice'),
    essay('essay', 'Essay'),
    shortAnswer('shortAnswer', 'Short Answer'),
    trueOrFalse('trueOrFalse', 'True or False'),
    invalidType('invalidType', 'Invalid Type');

    final String value;
    final String displayName;

    const QuestionType(this.value, this.displayName);

    static QuestionType mapStringToQuestionType(String value) {

        return values.firstWhere(
            (q) => q.value == value,
            orElse: () => QuestionType.invalidType
        );

    }
}

class AssignmentQuestion {
    final QuestionType type;  
    final String question;    
    final List<Answers> answers;    
    final int points;         

    AssignmentQuestion(this.type, this.question, this.answers, this.points);

    factory AssignmentQuestion.fromJson(Map<String, dynamic> json) {
        QuestionType questionType = QuestionType.mapStringToQuestionType(json['type']);

        return AssignmentQuestion(
            questionType,
            json['question'] ?? '',  
            (json['answers'] as List).map((answerJson) => Answers.fromJson(answerJson)).toList(),
            json['points'] ?? 0,  
        );
    }
}

class Answers  {

    final int id;
    final String text;
    final bool isCorrect;
    final bool isStudentAnswered;

    Answers(
        this.id,
        this.text, 
        this.isCorrect, 
        this.isStudentAnswered,
    ); 

    factory Answers.fromJson(Map<String, dynamic> json) {
        return Answers(
            json["id"] ?? 0,
            json['text'] ?? '',  
            json['is_correct'] == 1,  
            json['is_student_answered'] == 1, 
        );
    }
}