//With ListView.builder()
//new_transaction.dart receives an updated list of transactions from user_transaction.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList1 extends StatelessWidget {
  final List<Transaction>
      trans; // By doing this, the content of the list is import from other file
  TransactionList1(this.trans); // as a list of Transactions
  //In this file, only a list is built by taking certain inputs from another file.
  List<String> get transNew{
    return List.generate(trans.length, (i) {
      String manipulatedAmt;
      if (trans[i].amount >= 10000000.0){
        manipulatedAmt = ((trans[i].amount * 0.0000001).toStringAsFixed(2) + 'cr');
      }else if (trans[i].amount >= 100000.0){
        manipulatedAmt = ((trans[i].amount * 0.00001).toStringAsFixed(2) + 'lk');
      }else if (trans[i].amount >= 1000.0){
        manipulatedAmt = ((trans[i].amount * 0.001).toStringAsFixed(2) + 'k');
      }else{
        manipulatedAmt = trans[i].amount.toString();
      }
      return manipulatedAmt;
    });
  }
  @override 
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: trans.isEmpty
          ? Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(5),
              child: Center(
                child: Text(
                      'Add Items',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 100,
                        color: Colors.white,
                      ),
                    ),
              ),
              margin: EdgeInsets.all(10),
            )
          : ListView.builder(
              itemCount: trans.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 40, //elevation creates a shadowing effect.
                  child: Row(
                    children: <Widget>[
                      Container(
                        //container starts----this container contains the amount/price section.
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            //This is the a way to give border to a container.
                            width: 3,
                            style: BorderStyle.solid,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: Text(
                          //expression "'\$'+ n.amount.toString()" can also be written as "\$${n.amount}",
                          //where, the '$' after the '\$' is used to wrap n.amount in string i.e. String Interpolation.
                          'Rs' + transNew[index],// was written as trans[index].amount.toStringAsFixed(2) before,
                              // .toString() is used to convert the 'int' type of the amount to 'String' type
                               //where .toStringAsFixed(2) is a special type with the limitiation of only 2 decimal digits allowed after the point
                          style: Theme.of(context).textTheme.title,
                        ),
                      ), //Container ends
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            trans[index].title,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            DateFormat('MMMM d, y').format(trans[index].date),
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
              },
            ),
    );
  }
}
