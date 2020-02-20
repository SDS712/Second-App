import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//new_transaction.dart receives the function 'addTrans' from main.dart, to add a new transaction.
class NewTransaction extends StatefulWidget {
  final Function addTrans;
  NewTransaction(this.addTrans);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInput =
      TextEditingController(); // These controllers accepts the user input and stores in the variable.
  final amountInput = TextEditingController();
  DateTime selectedDate;

  void presentDatePicker() {
    showDatePicker(
      //built in Future which shows a material design Date Picker
      //The returned [Future] resolves to the date selected by the user when the user closes the dialog.
      //If the user cancels the dialog, null is returned.
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      // .then is a constructor which takes a function and receives the pickedDate as argument.
      if (pickedDate == null) {
        //where, 'pickedDate' is just a name of the variable
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  void submitData() {
    final enteredTitle = titleInput.text;
    final enteredAmount = double.parse(amountInput
        .text); //this is done to convert the String type into double type.
    //This is done as our addTransaction function receives the amount of type double.
    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      // '||' is the OR operator.
      return; // here, 'return' is used to stop the function execution if the condition is met.
      // any code inside a function after 'return' is not reached.
    }
    widget.addTrans(
      //widget. is used to get access to the addTrans(from NewTransaction class)
      //method to NewTransactionState class
      enteredTitle,
      enteredAmount,
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                //EXPLORE!!!
                // onChanged: (val) {    ......(alternate code/method)
                //   titleInput = val;    ......(alternate code/method)
                // },
                controller: titleInput,
                decoration: InputDecoration(
                    labelText:
                        'Title'), //a nice way to give labels to the textfields.
                keyboardType: TextInputType.text, //define the keyboard type
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                controller: amountInput,
                // onChanged: (val) {    ......(alternate code/method)
                //   amountInput = val;   ......(alternate code/method)
                // },
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      // Expanded is a replacement widget for Flexible(FlexFit.tight)
                      child: Text(selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date : ${DateFormat('dd/MM/yyyy').format(selectedDate)}'),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            onPressed: presentDatePicker,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                              ),
                            ),
                          )
                        : FlatButton(
                            onPressed: presentDatePicker,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                              ),
                            ),
                          )
                  ],
                ),
              ),
              FlatButton(
                color: Theme.of(context).primaryColor,
                child: Text('Add Transation',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.button.color)),
                onPressed: submitData,
              ),
              SizedBox(
                height: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
