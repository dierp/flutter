import 'package:flutter/foundation.dart';

class Word {
  int id;
  String word;
  String image;
  String syllables;
  int difficulty;
  String category;
  bool available;

  Word(
      {this.id,
      @required this.word,
      @required this.image,
      @required this.syllables,
      @required this.difficulty,
      this.category,
      this.available = true});
}
