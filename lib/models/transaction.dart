import 'package:flutter/material.dart';

class Transaction {//we are creating our own Class here.
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({//constructors
    @required this.id,
    @required this.amount,
    @required this.date,
    @required this.title,
  });
}
