import 'package:expanses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Expanse extends StatelessWidget {
  final Transaction expanse;
  final Function(String) _removeExpanse;

  Expanse(this.expanse, this._removeExpanse);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('R\$ ${expanse.value.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          expanse.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('MMM,d y').format(expanse.createdAt),
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? FlatButton.icon(
                icon: Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                onPressed: () => _removeExpanse(expanse.id),
                label: Text('Delete'),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => _removeExpanse(expanse.id),
              ),
      ),
    );
  }
}
