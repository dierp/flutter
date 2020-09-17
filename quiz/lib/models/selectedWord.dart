import 'package:quiz/models/words.dart';

class SelectedWord {
  int id;
  String word;
  String syllables;
  List<Word> options;

  SelectedWord({
    this.id,
    this.word,
    this.syllables,
    this.options,
  });
}
