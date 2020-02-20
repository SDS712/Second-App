import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transNew,
    @required this.trans,
    @required this.deleteTrans,
  }) : super(key: key);

  final String transNew;
  final Transaction trans;
  final Function deleteTrans;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      elevation: 5,
      child: ListTile(
        //special widget
        leading: CircleAvatar(
          //CircleAvatar is often used for images
          //Alternate code to CircleAvatar:-

          // Container(
          //   height: 30,
          //   width: 30,
          //   decoration: BoxDecoration(
          //     color:Theme.of(context).primaryColor,
          //     shape: BoxShape.circle),
          // )

          radius: 30,
          child: Padding(
            //Padding is used in place of a container with only one constructor i.e. padding
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: Text(
                '₹' + transNew,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        title: Text(
          trans.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat('dd MMMM, yyyy').format(trans.date),
        ),
        trailing: MediaQuery.of(context).size.width > 450
            ? FlatButton.icon(
                onPressed: () => deleteTrans(trans.id),
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteTrans(trans.id),
                color: Theme.of(context)
                    .errorColor, //errorColor is by default set to red, though you can set it manually in Theme Widget.
              ),
      ),
    );
  }
}
