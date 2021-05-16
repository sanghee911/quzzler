import 'package:quizzler/question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('세상에서 가장 빠른 동물은 거북이다.', false),
    Question('세상에서 가장 높은 산은 백두산이다.', false),
    Question('김민우는 잠이 많다.', true),
    Question('일본은 아시아에서 가장 동쪽에 있는 나라이다.', true),
    Question('일본은 수도는 쿄토이다.', false),
  ];

  bool nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
      return true;
    }
    return false;
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  void reset() {
    _questionNumber = 0;
  }
}