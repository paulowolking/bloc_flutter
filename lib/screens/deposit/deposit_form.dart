import 'package:bytebank/models/balance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _titleAppBar = 'Receber depósito';

class DepositForm extends StatelessWidget {
  static const _placeholderValue = '0.00';
  static const _placeholTitleValue = 'Valor';
  static const _placeholTitleConfirm = 'Confirmar';

  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  _placeholTitleValue,
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('Depositar'),
                      onPressed: () {
                        _createDeposit(context);
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Nova transferência'),
                      onPressed: () {
                        Navigator.of(context).pushNamed('contacts_list');
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _createDeposit(context) {
    final double? value = double.tryParse(_valueController.text);
    if (_validDeposit(value)) {
      _updateState(context, value);
      Navigator.pop(context);
    }
  }

  bool _validDeposit(value) {
    return value != null;
  }

  void _updateState(context, value) {
    Provider.of<Balance>(context, listen: false).add(value);
  }
}
