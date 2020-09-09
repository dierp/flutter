import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Map option;
  final void Function(Map) selected;

  Answer(this.option, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        // margin: EdgeInsets.all(10),
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.blue,
          child: Text(option['option']),
          onPressed: () => selected(option),
        ));
  }
}
