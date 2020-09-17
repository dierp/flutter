import 'package:flutter/material.dart';

import './models/words.dart';
import './models/selectedWord.dart';
import './question_options.dart';
import './data/dummy_data.dart';
import 'dart:math';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final List<Word> _words = [...wordsList];
  // final List<Word> _wordsSolved = [];
  final List<Word> _wordsAvailable = [...wordsList];
  SelectedWord _selectedWord;

  // List _optionsShuffled;

  List<Word> shuffle(List<Word> items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    print('Build da question foi chamada!!!');

    final _availableHeight = MediaQuery.of(context).size.height -
        30 -
        MediaQuery.of(context).padding.top;

    void pickAWord() {
      // print(_wordsAvailable.length);
      // print(_words.length);

      if (_wordsAvailable.length == 0) {
        return null;
      }

      final _wordIndex = Random().nextInt(_wordsAvailable.length);
      final _question = _wordsAvailable[_wordIndex];
      List<Word> _optionsReducedToFour = [];
      // print(_optionsReducedToFour);

      List<Word> _options = _words
          .where((element) => element.word != _wordsAvailable[_wordIndex].word)
          .toList();

      List<Word> _optionsShuffled = shuffle(_options);
      for (var i = 0; i < 3; i++) {
        _optionsShuffled[i].available = true;
        _optionsReducedToFour.add(_optionsShuffled[i]);
      }
      _wordsAvailable[_wordIndex].available = true;
      _optionsReducedToFour.insert(
          Random().nextInt(4), _wordsAvailable[_wordIndex]);

      setState(() {
        _wordsAvailable.removeAt(_wordIndex);

        _selectedWord = SelectedWord(
          id: Random().nextInt(10000),
          word: _question.word.toString(),
          syllables: _question.syllables,
          options: _optionsReducedToFour,
        );
      });
    }

    void reset() {
      for (var i = 0; i < _words.length; i++) {
        _wordsAvailable.add(_words[i]);
      }
      pickAWord();
    }

    return Container(
      height: _availableHeight,
      width: MediaQuery.of(context).size.width,
      child: _selectedWord != null
          ? Column(
              children: [
                if (_wordsAvailable.length != 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 30),
                        child: _selectedWord.word != ''
                            ? Text(
                                _selectedWord.word.toUpperCase(),
                                style: TextStyle(fontSize: 40),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                if (_wordsAvailable.length != 0)
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    child: _selectedWord.syllables != ''
                        ? Text(
                            _selectedWord.syllables.toUpperCase(),
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )
                        : Container(),
                  ),
                if (_wordsAvailable.length != 0)
                  Expanded(
                    child: GridView.count(
                        // Cria um grid com duas colunas
                        crossAxisCount: 2,
                        // Gera 100 Widgets que exibem o seu índice
                        children: _selectedWord.options
                            .map((e) => QuestionOptions(
                                  option: e,
                                  pickAWord: pickAWord,
                                  rightAnswer: _selectedWord.word == e.word,
                                ))
                            .toList()),
                  ),
                Container(
                  child: _wordsAvailable.length == 0
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                child: Text('Recomeçar'),
                                onPressed: () => reset(),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () => pickAWord(),
                  child: Text('COMEÇAR'),
                ),
              ],
            ),
    );
  }
}
