import 'dart:io'; //dart:io is used for the Platform widget
import 'dart:ui';

import 'package:flutter/cupertino.dart'; //for IOS
import 'package:flutter/material.dart'; //for material(android)
import 'package:flutter/services.dart';

import './Widgets/new_transaction.dart';
import './Widgets/transaction_list.dart';
import './Widgets/chart.dart';
import './models/transaction.dart';

void main() {
  SystemChrome.setPreferredOrientations(
    [
      //This sets the device orientation as specified.
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //needs a context
    return MaterialApp(
      //Main widget which builds the app
      title: 'Tracker',
      theme: ThemeData(
        //ThemeData lets us to set a Uniform Theme through out the app// EXPERIMENT //
        primarySwatch: Colors.indigo,
        accentColor: Colors.red[400],
        errorColor: Colors.deepOrangeAccent[700],
        fontFamily:
            'QuickSand', // first it is needed to add the font in the project folder
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions = [];
  bool showChartToggle = false;

  void addTransaction(String ntitle, double namount, DateTime chosenDate) {
    //These functions are used to embbed logic
    final newTrans = Transaction(
      id: DateTime.now().toString(),
      date: chosenDate,
      title: ntitle,
      amount: namount,
    );
    setState(() {
      transactions.add(newTrans); //this is the main executer.
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((n) {
        //.removeWhere is opposite of where
        return n.id == id;
      });
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      //needs a context
      context: ctx,
      builder: (_) {
        return NewTransaction(addTransaction);
      },
    );
  }

  List<Transaction> get recentTransaction {
    return transactions.where(
      (n) {
        return n.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList(); //'where' allows us to run a function on every item of the list,
    //and only includes an item in the new list if the function passed is true
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    Widget buildAppBar() {
      return Platform.isIOS
          ? CupertinoNavigationBar(
              middle: Text('Expense Tracker'),
              trailing: GestureDetector(
                child: Icon(
                  CupertinoIcons.delete,
                ),
                onTap: () => startAddNewTransaction(context),
              ),
            )
          : AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => startAddNewTransaction(context),
                ),
              ],
              title: Text('Expense Tracker'),
            );
    }

    final PreferredSizeWidget appBar = buildAppBar();
    Container showChart(double height) {
      return Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            //MediaQuery allows you to fetch information about device orientation,measures,user settings,etc
            height,
        child: Chart(
          recentTransaction,
        ),
      );
    }

    Container showTransactionList(double height) {
      return Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            height,
        child: TransactionList(
          transactions,
          deleteTransaction,
        ),
      );
    }

    List<Widget> builderForLandscape() {
      return [
        Container(
          //'show chart toggle'
          height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top) *
              0.1, //MediaQuery allows you to fetch information about device orientation,measures,user settings,etc
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Show Chart'),
              Switch.adaptive(
                value: showChartToggle,
                onChanged: (val) {
                  setState(() {
                    showChartToggle = val;
                  });
                },
              )
            ],
          ),
        ),
        Column(
          children: <Widget>[
            showChartToggle == true ? showChart(0.7) : showTransactionList(0.9),
          ],
        ),
      ];
    }

    Widget builderForPortrait() {
      return Column(
        children: <Widget>[
          showChart(0.3),
          showTransactionList(0.7),
        ],
      );
    }

    final pageBody = SafeArea(
      child: ListView(
        //body should contain a Chart at the top and a list of Transactions above one another, so we use ListView/column.
        children: <Widget>[
          if (isLandscape) ...builderForLandscape(),
          if (!isLandscape) builderForPortrait(),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => startAddNewTransaction(context)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
