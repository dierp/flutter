import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'models/words.dart';

class QuestionOptions extends StatefulWidget {
  final Word option;
  final Function pickAWord;
  final bool rightAnswer;
  final bool optionAvailable;

  final player = AudioPlayer();

  Future<bool> playYeah() async {
    try {
      await player.setAsset('assets/audios/kids-yeah.mp3');
      await player.play();
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> playError() async {
    try {
      await player.setAsset('assets/audios/error.mp3');
      await player.play();
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  QuestionOptions({
    this.option,
    this.pickAWord,
    this.rightAnswer,
    this.optionAvailable,
  });

  @override
  _QuestionOptionsState createState() => _QuestionOptionsState();
}

class _QuestionOptionsState extends State<QuestionOptions> {
  // bool optionAvailable = true;

  @override
  Widget build(BuildContext context) {
    print(
        'Build chamada para ${widget.option.word} - $widget.option.available');
    return Container(
        margin: const EdgeInsets.all(10),
        child: RaisedButton(
          color: widget.option.available
              ? Colors.white
              : widget.rightAnswer ? Colors.green : Colors.red,
          child: widget.option.available
              ? Image.asset(
                  'assets/images/${widget.option.image}',
                  fit: BoxFit.cover,
                )
              : Container(
                  child: Icon(
                  widget.rightAnswer ? Icons.thumb_up : Icons.cancel,
                  color: Colors.white,
                )),
          onPressed: () {
            if (widget.rightAnswer) {
              setState(() {
                widget.option.available = false;
              });
              widget.playYeah().then((value) {
                if (value) {
                  widget.pickAWord();
                } else {
                  print('Error while trying to play the song.');
                }
              });
            } else {
              setState(() {
                widget.option.available = false;
              });
              widget.playError();
            }
          },
        ));
  }
}
