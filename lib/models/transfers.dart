import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class Tranfers extends ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  void add(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
