import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//chartBar is dependent on chart for the weekdays, amount spent on that day and the percent of total amount spent in the week.   
class ChartBar extends StatelessWidget {
  //widget created by us
  final String label;
  final double spendingAmt;
  final double pctSpendingOfTotal;

  String get amount {
    //getters are special functions with any arguments
    String manipulatedAmt;
    if (spendingAmt >= 10000000.0) {
      manipulatedAmt = ((spendingAmt * 0.0000001).toStringAsFixed(0) + 'cr');
    } else if (spendingAmt >= 100000.0) {
      manipulatedAmt = ((spendingAmt * 0.00001).toStringAsFixed(0) + 'lk');
    } else if (spendingAmt >= 1000.0) {
      manipulatedAmt = ((spendingAmt * 0.001).toStringAsFixed(0) + 'k');
    } else {
      manipulatedAmt = spendingAmt.toStringAsFixed(0);
    }
    return manipulatedAmt;
  } //by doing this we get the spendingAmt with k/lk/cr based on the functin defined above
  //and the final value is stored in new variable 'amount'

  ChartBar(this.label, this.spendingAmt, this.pctSpendingOfTotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (
      //LayoutBuilder is a special function, it is used to give constraints with respect to available space.  
      context, //It takes a function under the named argument 'builder'
      constraints, //This function takes two arguments context and contraints
    ) {
      //constraints are used to apply dimensional constraints on the widgets.
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.12,//make sure these add-up
            child: FittedBox(child: Text(amount)),
          ), // fittedBox restrains the child in its assigned space..so the text skrinks if it is lengthy
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ), //SizedBox are used to give space
          Container(
            height: constraints.maxHeight * 0.66,
            width: 10,
            child: Stack(//Stack is used to keep elements over on top of each other(in 3D space)---elements are ordered from bottom to top
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(220, 220, 220, 1),//RGBO (where, O = opacity) values for grey   
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,//border color
                      width: 1,
                    ),
                  ),
                ),
                FractionallySizedBox(//creates as the name suggests.
                  heightFactor: pctSpendingOfTotal,// this is done to add the height factor dynamically, but still don't know how to give direction.
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.12,
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
