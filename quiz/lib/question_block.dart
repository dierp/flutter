import 'package:flutter/material.dart';
import './question_block/answer.dart';
import './question_block/question.dart';

class QuestionBlock extends StatelessWidget {
  final Map<String, Object> _questions;
  final Function _selected;
  final bool hasQuestion;

  QuestionBlock(this._questions, this._selected, this.hasQuestion);

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> answers =
        hasQuestion ? _questions['answers'] : null;
    List<Widget> widgets =
        hasQuestion ? answers.map((e) => Answer(e, _selected)).toList() : null;

    return hasQuestion
        ? Container(
            child: Column(
            children: [
              Question(_questions['question']),
              ...widgets,
            ],
          ))
        : Container();
  }
}
