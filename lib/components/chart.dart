import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {super.key});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        final transaction = recentTransactions[i];
        bool sameDay = transaction.date.day == weekDay.day;
        bool sameMonth = transaction.date.month == weekDay.month;
        bool sameYear = transaction.date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += transaction.value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(
      0.0,
      (sum, tr) => sum + (tr['value'] as double),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'] as String,
                value: tr['value'] as double,
                percentage: _weekTotalValue > 0
                    ? (tr['value'] as double) / _weekTotalValue
                    : 0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
