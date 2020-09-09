import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final List<int> _score;
  final Function() _restart;

  Result(this._score, this._restart);
  @override
  Widget build(BuildContext context) {
    int totalScore = _score.reduce((value, element) => value + element);
    return Column(
      children: [
        Column(
          children: [
            Text('Congratulations! Your total score is: $totalScore',
                style: TextStyle(
                  fontSize: 28,
                )),
            RaisedButton(
                color: Colors.orange,
                child: Text(
                  'Restart',
                ),
                onPressed: _restart)
          ],
        )
      ],
    );
  }
}
