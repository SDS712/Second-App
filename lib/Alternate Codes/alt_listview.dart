//listview from main.dart
//ListView(
//         //body should contain a Chart at the top and a list of Transactions above one another, so we use ListView/column.
//         children: <Widget>[
//           isLandscape == false
//               ? Column(
//                   children: <Widget>[
//                     showChart(0.3),
//                     showTransactionList(0.7),
//                   ],
//                 )
//               : Column(
//                   children: <Widget>[
//                     Container(
//                       //'show chart toggle'
//                       height: (MediaQuery.of(context).size.height -
//                               appBar.preferredSize.height -
//                               MediaQuery.of(context).padding.top) *
//                           0.1, //MediaQuery allows you to fetch information about device orientation,measures,user settings,etc
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Text('Show Chart'),
//                           Switch(
//                             value: showChartToggle,
//                             onChanged: (val) {
//                               setState(() {
//                                 showChartToggle = val;
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                     showChartToggle == true
//                         ? showChart(0.7)
//                         : showTransactionList(0.9),
//                   ],
//                 ),
//         ],
//       ),import 'dart:ffi';
