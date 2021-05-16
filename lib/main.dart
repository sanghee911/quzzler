import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/question.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            'images/logo.png',
            height: 30,
          ),
        ),
        body: QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  int correctAnswerCount = 0;
  int wrongAnswerCount = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    if (userPickedAnswer == correctAnswer) {
      setState(() {
        scoreKeeper.add(
            Icon(Icons.radio_button_off, color: Colors.green)
        );
      });
      correctAnswerCount++;
    } else {
      setState(() {
        scoreKeeper.add(
            Icon(Icons.close, color: Colors.red)
        );
      });
      wrongAnswerCount++;
    }
    if (!quizBrain.nextQuestion()) {
      int totalQuestions = scoreKeeper.length;
      double score = correctAnswerCount / scoreKeeper.length * 100;
      Alert(
        context: context,
        type: AlertType.info,
        title: '총 문제수: $totalQuestions\n정답: $correctAnswerCount\n틀린답: $wrongAnswerCount',
        desc: "당신의 성적은 $score점입니다.",
        // image: Image.asset('assets/logo.png'),
        buttons: [
          DialogButton(
            child: Text(
              "종료하기",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      setState(() {
        quizBrain.reset();
        scoreKeeper = [];
        correctAnswerCount = 0;
        wrongAnswerCount = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: scoreKeeper,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(true),
                  child: Text(
                    '참',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(false),
                  child: Text(
                    '거짓',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
