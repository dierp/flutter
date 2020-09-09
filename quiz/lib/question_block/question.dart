import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String perguntaSelecionada;

  Question(this.perguntaSelecionada);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      // Ctrl + . Wrap with container
      child: Text(
        perguntaSelecionada,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
