import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final priceController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final price = double.tryParse(priceController.text) ?? 0.00;

    if (title.isEmpty || price <= 0) {
      return;
    }

    widget.onSubmit(
      title,
      price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price R\$'),
              onSubmitted: (_) => _submitForm(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: _submitForm,
                  child: Text('New Transaction'),
                  textColor: Colors.purple,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
