import 'package:expanses/components/chart.dart';
import 'package:expanses/components/transaction_form.dart';
import 'package:expanses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import './components/expanse.dart';

main() => runApp(ExpansesApp());

class ExpansesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purple[600],
        fontFamily: 'QuickSand',
        errorColor: Colors.red[700],
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
    ),
    Transaction(
      id: 't3',
      title: 'New Skate',
      value: 125.80,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't4',
      title: 'Parking Ticket',
      value: 50,
      createdAt: DateTime.now().subtract(Duration(days: 2)),
    )
  ];
  void _addTransaction(String title, double price, DateTime createdAt) {
    final newExpanse = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: price,
      createdAt: createdAt,
    );

    setState(() {
      _transactions.insert(0, newExpanse);
    });

    Navigator.of(context).pop();
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
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
    final bool _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final _rem = MediaQuery.of(context).textScaleFactor;
    final _appBar = AppBar(
      title: Text(
        'Personal Expanses',
        style: TextStyle(fontSize: _rem * 20),
      ),
      // backgroundColor: Colors.purple,
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransacionFormModal(context),
        ),
      ],
    );
    final _availableHeight = MediaQuery.of(context).size.height -
        _appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: _availableHeight * (_isLandscape ? 0.5 : 0.3),
              padding: const EdgeInsets.all(10),
              child: Chart(_transactions),
            ),
            Container(
              height: _availableHeight * (_isLandscape ? 0.5 : 0.7),
              child: _transactions.isEmpty
                  ? Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'No transactions found!',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 200,
                          child: Image.asset(
                            'assets/images/waiting.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    )
                  : ListView.builder(
                      itemCount: _transactions.length,
                      itemBuilder: (context, index) {
                        return Expanse(
                            _transactions[index], _removeTransaction);
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // backgroundColor: Colors.purple,
        onPressed: () => _openTransacionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
