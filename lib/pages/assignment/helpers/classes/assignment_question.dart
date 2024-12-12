// ignore_for_file: non_constant_identifier_names

enum QuestionType  {
    multipleChoice,
    essay,
    shortAnswer,
    trueOrFalse;
}

class AssignmentQuestion {
    final QuestionType type;  
    final String question;    
    final List<Answers> answers;    
    final int points;         

    AssignmentQuestion(this.type, this.question, this.answers, this.points);

    factory AssignmentQuestion.fromJson(Map<String, dynamic> json) {
        QuestionType questionType = _mapStringToQuestionType(json['type']);

        return AssignmentQuestion(
            questionType,
            json['question'] ?? '',  
            (json['answers'] as List).map((answerJson) => Answers.fromJson(answerJson)).toList(),
            json['points'] ?? 0,  
        );
    }

    static QuestionType _mapStringToQuestionType(String type) {
        switch (type) {
            case 'multipleChoice':
                return QuestionType.multipleChoice;
            case 'essay':
                return QuestionType.essay;
            case 'shortAnswer':
                return QuestionType.shortAnswer;
            case 'trueOrFalse':
                return QuestionType.trueOrFalse;
            default:
            return QuestionType.multipleChoice;
        }
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