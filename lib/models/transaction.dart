import 'package:flutter/material.dart';

class Transaction {
  String id;
  String title;
  DateTime date;
  double amount;

  Transaction(
      {@required this.amount,
      @required this.date,
      @required this.id,
      @required this.title});
}
