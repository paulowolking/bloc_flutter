import 'package:bytebank/models/notifiers/balance.dart';
import 'package:bytebank/values/translate_i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = TranslateI18n(context);

    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              i18n.your_balance,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
            child: Consumer<Balance>(builder: (context, value, child) {
              return Text(
                value.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
