//With ListView

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_tracker_app/models/transaction.dart';

class TransactionList2 extends StatelessWidget {
  final List<Transaction> trans;
  TransactionList2(this.trans);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,//ListView needs a predetermined height to work properly, as ListView brings with it infinite height.
      child: ListView(//ListView is equivalent to SingleChildScrollView(child:Column())
          //nested list which contains list of transactions.
          children: trans.map((n) {
            return Card(
              elevation: 40,
              child: Row(
                children: <Widget>[
                  Container(
                    //container starts----this container contains the amount/price section.
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        style: BorderStyle.solid,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Text(
                      //expression "'\$'+ n.amount.toString()" can also be written as "\$${n.amount}",
                      //where the '$' after the '\$' is used to wrap n.amount in string i.e. String Interpolation.
                      '\$' +
                          n.amount
                              .toString(), // .toString() is used to convert the 'int' type of the amount to 'String' type
                      style: TextStyle(
                        //which is the only type accepted by text.
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent[50],
                      ),
                    ),
                  ), //Container ends
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        n.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('MMMM d, y').format(n.date),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blueGrey[300],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
    );
  }
}
