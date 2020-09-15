import 'package:expanses/models/transaction.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      List<double> weekDayTransactions = recentTransactions
          .where((element) {
            return element.createdAt.day == weekDay.day &&
                element.createdAt.month == weekDay.month &&
                element.createdAt.year == weekDay.year;
          })
          .toList()
          .map((e) => e.value)
          .toList();

      return {
        'day': DateFormat.E().format(weekDay)[0].toString(),
        'value': weekDayTransactions.length == 0
            ? 0.00
            : weekDayTransactions.reduce((value, element) => value + element)
        // .toStringAsFixed(2),
      };
    }).reversed.toList();
  }

  double get _weekTotalSpent {
    return groupedTransactions.fold(0.00, (previousValue, element) {
      return previousValue + element['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(5),
        // height: MediaQuery.of(context).size.height * 0.2,
        child: Card(
          elevation: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...groupedTransactions.map((e) {
                return Container(
                  color: Colors.blueAccent[300],
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        height: constraints.maxHeight * 0.15,
                        child: FittedBox(
                          child:
                              Text((e['value'] as double).toStringAsFixed(2)),
                        ),
                      ),
                      Container(
                        height: constraints.maxHeight * 0.45,
                        width: 10,
                        // color: Colors.purple,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(220, 220, 220, 1),
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            FractionallySizedBox(
                              heightFactor: _weekTotalSpent == 0
                                  ? 0
                                  : (e['value'] as double) / _weekTotalSpent,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: constraints.maxHeight * 0.15,
                        child: FittedBox(
                          child: Text(e['day'].toString()),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      );
    });
  }
}
