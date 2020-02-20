//With ListView.builder()
//with ListTile
//new_transaction.dart receives an updated list of transactions from user_transaction.dart

import 'package:flutter/material.dart';

import 'transaction_item.dart';
import '../models/transaction.dart';

//transactionList is dependent on main for the trans and deletetrans
class TransactionList extends StatelessWidget {
  final List<Transaction>
      trans; // By doing this, the content of the list is imported from other file
  final deleteTrans;
  TransactionList(this.trans, this.deleteTrans); // as a list of Transactions
  //In this file, only a list is built by taking certain inputs from another file.
  List<String> get transNew {
    return List.generate(
      trans.length,
      (i) {
        String manipulatedAmt;
        if (trans[i].amount >= 10000000.0) {
          manipulatedAmt =
              ((trans[i].amount * 0.0000001).toStringAsFixed(0) + 'cr');
        } else if (trans[i].amount >= 100000.0) {
          manipulatedAmt =
              ((trans[i].amount * 0.00001).toStringAsFixed(0) + 'lk');
        } else if (trans[i].amount >= 1000.0) {
          manipulatedAmt = ((trans[i].amount * 0.001).toStringAsFixed(0) + 'k');
        } else {
          manipulatedAmt = trans[i].amount.toStringAsFixed(0);
        }
        return manipulatedAmt;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              //.builder is a constructor of ListView where builder is called only for the visible children
              itemCount: trans.length,
              itemBuilder: (context, index) {
                return TransactionItem(
                    key: ValueKey(trans[index].id),
                    transNew: transNew[index],
                    trans: trans[index],
                    deleteTrans: deleteTrans);
              },
            ),
    );
  }
}
