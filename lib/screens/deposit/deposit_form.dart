import 'package:bytebank/bloc/bloc_state.dart';
import 'package:bytebank/bloc/cubit/deposit_cubit.dart';
import 'package:bytebank/components/container.dart';
import 'package:bytebank/models/notifiers/balance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

const _titleAppBar = 'New deposit';

class DepositContainer extends BlocContainer {
  const DepositContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DepositCubit>(
        create: (buildContext) {
          return DepositCubit();
        },
        child: BlocListener<DepositCubit, BlocState>(
          listener: (context, state) {
            if (state is DoneBlocState) {
              Navigator.pop(context);
            }
          },
          child: _DepositForm(),
        ));
  }
}

class _DepositForm extends StatelessWidget {
  static const _placeholderValue = '0.00';
  static const _placeholTitleValue = 'Value';
  static const _placeholTitleConfirm = 'Confirm';

  final TextEditingController _valueController = TextEditingController();

  _DepositForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_titleAppBar),
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
                  decoration:
                      const InputDecoration(labelText: _placeholderValue),
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
                      child: const Text(_placeholTitleConfirm),
                      onPressed: () {
                        BlocProvider.of<DepositCubit>(context)
                            .createDeposit(context, _valueController.text);
                      },
                    ),
                    ElevatedButton(
                      child: const Text('New transfer'),
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
