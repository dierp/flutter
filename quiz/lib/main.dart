import 'package:flutter/material.dart';
import './question_block.dart';
import './result.dart';

void main() {
  runApp(QuizApp());
}

class _QuizAppState extends State<QuizApp> {
  int _selectedQuestion = 0;
  List<int> _answersScore = [];

  _nextQuestion(Map optionClicked) {
    if (hasQuestion) {
      setState(() {
        _answersScore[_selectedQuestion] = optionClicked['score'];
        _selectedQuestion++;
      });
    }
  }

  _previousQuestion() {
    setState(() {
      _selectedQuestion > 0 ? _selectedQuestion-- : 0;
    });
  }

  _restartQuiz() {
    setState(() {
      _selectedQuestion = 0;
      _answersScore = _questions.map((e) => 0).toList();
    });
  }

  final List<Map<String, Object>> _questions = const [
    {
      'question': 'What is your favorite color?',
      'answers': [
        {'option': 'Black', 'score': 6},
        {'option': 'Red', 'score': 4},
        {'option': 'Blue', 'score': 10},
        {'option': 'Green', 'score': 8},
      ]
    },
    {
      'question': 'What is your favorite animal?',
      'answers': [
        {'option': 'Rabbit', 'score': 6},
        {'option': 'Dog', 'score': 10},
        {'option': 'Cat', 'score': 4},
        {'option': 'Bird', 'score': 8},
      ]
    },
  ];

  bool get hasQuestion {
    return _selectedQuestion < _questions.length;
  }

  @override
  Widget build(BuildContext context) {
    _answersScore = _answersScore.length == 0
        ? _questions.map((e) => 0).toList()
        : _answersScore;

    return MaterialApp(
      title: 'Quiz Game',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Quizz')),
        body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                // color: Colors.black38,
                child: hasQuestion
                    ? QuestionBlock(
                        _questions[_selectedQuestion],
                        _nextQuestion,
                        hasQuestion,
                      )
                    : Result(_answersScore, _restartQuiz),
              ),
              Container(
                child: Visibility(
                    visible: _selectedQuestion != _answersScore.length &&
                        _selectedQuestion > 0,
                    child: Align(
                      // alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        child: Text('Return'),
                        onPressed: _previousQuestion,
                      ),
                    )),
              ),
            ]),
      ),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() {
    return _QuizAppState();
  }
}
