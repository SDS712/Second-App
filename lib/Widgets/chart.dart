import 'package:flutter/material.dart';
import './chartBar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
//chart is dependent on the main widget for 'recentTransaction',

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  //first we need to group the transactions as per the day of the week.
  //getters are properties which are calculated dynamically
  List<Map<String, Object>> get groupedTransactions {
    //getters are functions without arguments
    return List.generate(
      7,
      (index) {
        //.generate is a special type of constructor, used to generate a list
        // this constructor takes 2 positional arguments i.e. length of the list and a Function which takes a index
        final weekDay = DateTime.now().subtract(Duration(days: index));

        var totalSum = 0.0;
        for (var i = 0; i < recentTransaction.length; i++) {
          // note the semi collons ';'
          if (recentTransaction[i].date.day == weekDay.day &&
              recentTransaction[i].date.month == weekDay.month &&
              recentTransaction[i].date.year == weekDay.year) {
            totalSum += recentTransaction[i].amount;
          }
        }
        return {
          'day': index == 0
              ? 'Today'
              : DateFormat.E().format(weekDay).substring(
                  0), //substring is used to target specific parts of a string
          'amount': totalSum,
        };
      },
    )
        .reversed
        .toList(); //generally .toList is not required to be added as List.generate, generates list itself
  } //but, as we have added .reversed to reverse the order in which the list is generated,
  //.reversed creates iterables so, we need to convert the iterables into a list.

  double get totalSpending {
    return groupedTransactions.fold(0.0, (sum, item) {
      //where initially, sum = 0.0 and item takes value of evry item['amount']
      return sum + item['amount']; //and lastly the the value of sum is derived
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactions);
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((n) {
            //map is used to map every element from the parent list one by one
            //and use that element in the widgets returned to create iterables.
            return Flexible(
              fit: FlexFit.tight, //FlexFit.tight lets the child
              // with this, we ensure the child can't grow and force a child to be in its assigned space
              child: ChartBar(
                n['day'],
                n['amount'],
                totalSpending == 0
                    ? 0.0
                    : (n['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
