import 'package:bytebank/bloc/cubit/deposit_cubit.dart';
import 'package:bytebank/values/translate_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepositForm extends StatelessWidget {
  final TextEditingController _valueController = TextEditingController();

  DepositForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = TranslateI18n(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.title_new_deposit),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  i18n.value,
                  style: const TextStyle(
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
                  decoration:
                  InputDecoration(labelText: i18n.placeholder_value),
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
                      child: Text(i18n.confirm),
                      onPressed: () {
                        BlocProvider.of<DepositCubit>(context)
                            .createDeposit(context, _valueController.text);
                      },
                    ),
                    ElevatedButton(
                      child: Text(i18n.new_transfer),
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
}
