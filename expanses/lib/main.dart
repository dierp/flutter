import 'package:expanses/components/transaction_form.dart';
import 'package:expanses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import './components/expanse.dart';

main() => runApp(ExpansesApp());

class ExpansesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      value: 125.80,
      createdAt: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Movie Theater',
      value: 50,
      createdAt: DateTime.now(),
    )
  ];
  void _addTransaction(String title, double price) {
    final newExpanse = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: price,
      createdAt: DateTime.now(),
    );

    setState(() {
      _transactions.insert(0, newExpanse);
    });

    Navigator.of(context).pop();
  }

  _openTransacionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expanses'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransacionFormModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text('Graphic'),
                elevation: 5,
              ),
            ),
            Container(
              height: 300,
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  return Expanse(_transactions[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        onPressed: () => _openTransacionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
